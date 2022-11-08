module Mentionable
  module ApplicationHelper
    def webmention_link_tag(href = mentionable.mentions_url)
      tag("link", { rel: "webmention", href: href })
    end

    def add_webmention_header(href = mentionable.mentions_url)
      response.set_header("Link", %(<#{href}>; rel="webmention"))
    end
  end
end
