require 'test_helper'

module Mentionable
  class MentionsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should accept valid source and target parameters" do
      post mentionable.mentions_url, params: {
        source: "https://www.example.com/source",
        target: "http://www.example.com/target"
      }

      assert_response :accepted
    end

    test "should not accept without source" do
      post mentionable.mentions_url, params: {
        target: "https://www.example.com"
      }

      assert_response :bad_request
      assert_equal "source and target params are required and must be HTTP or HTTPS URLs",
        @response.body
    end

    test "should not accept non-http/s source/target" do
      post mentionable.mentions_url, params: {
        source: "ftp://www.example.com/source",
        target: "https://www.example.com/target"
      }

      assert_response :bad_request
      assert_equal "ftp://www.example.com/source is not a valid URL. Please use http:// or https://",
        @response.body
    end

    test "should not accept identical source/target" do
      post mentionable.mentions_url, params: {
        source: "https://www.example.com/",
        target: "https://www.example.com/"
      }

      assert_response :bad_request
      assert_equal "source URL cannot be the same as target URL",
        @response.body
    end
  end
end
