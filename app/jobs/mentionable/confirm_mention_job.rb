require "net/http"
require "microformats"

# Query a {Mention#source} to confirm that it mentions the {Mention#target}.
# If the source mentions the target, the {Mention#status} is updated to
# "verified", else it is updated to "failed".
#
# Defaults to caching the HTTP response and parsed microformat data on the
# Mention.
class Mentionable::ConfirmMentionJob < ApplicationJob
  queue_as :default

  # @param mention [Mention] Mention to confirm
  # @param cache [Boolean] Cache the HTTP response and parsed microformat data
  #   on the {Mention}
  # @todo Use per-media-type rules to determine whether the source document
  #   mentions the target URL.
  # @see https://www.w3.org/TR/webmention/#webmention-verification-p-3
  def perform(mention, cache: true)
    source_page = Net::HTTP.get(URI(mention.source))
    source_page.i
    if cache
      Microformats.parse(source_page)
    end
  end
end
