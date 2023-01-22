require "net/http"

# Query a {Mention#source} to confirm that it mentions the {Mention#target}.
# If the source mentions the target, the {Mention#status} is updated to
# "verified", else it is updated to "failed".
#
# Defaults to caching the HTTP response on the {Mention}.
class Mentionable::ConfirmMentionJob < ApplicationJob
  queue_as :default

  # @param mention [Mention] Mention to confirm
  # @param cache [Boolean] Cache the HTTP response on the {Mention}
  # @todo Look for href/src/srcset attribute values, not bare mentions of URLs.
  #   Nokogiri?
  # @todo Use per-media-type rules to determine whether the source document
  #   mentions the target URL.
  # @see https://www.w3.org/TR/webmention/#webmention-verification-p-3
  def perform(mention, cache: true)
    source_page = Net::HTTP.get(URI(mention.source))
    mentioned_urls = URI.extract(source_page, %w[http https])
    if mentioned_urls.include?(mention.target)
      mention.status = "verified"
    else
      mention.status = "failed"
    end
    if cache
      mention.html = source_page
    end
    mention.save!
  end
end
