require "test_helper"

module Mentionable
  class ApplicationHelperTest < ActionView::TestCase
    def test_webmention_link_tag
      assert_dom_equal %(<link rel="webmention" href="http://test.host/webmention">),
        webmention_link_tag
    end

    def test_webmention_link_tag_with_href
      assert_dom_equal %(<link rel="webmention" href="http://test.host/sword">),
        webmention_link_tag("http://test.host/sword")
    end

    def test_add_webmention_header
      add_webmention_header

      assert response.headers["Link"].include?(%(<http://test.host/webmention>; rel="webmention"))
    end

    def test_add_webmention_header_with_href
      add_webmention_header "http://test.host/sword"

      assert response.headers["Link"].include?(%(<http://test.host/sword>; rel="webmention"))
    end
  end
end
