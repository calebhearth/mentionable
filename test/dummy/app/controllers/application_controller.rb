class ApplicationController < ActionController::Base
  before_action :add_webmention_header
  def default_url_options
    { host: "test.host" }
  end
end
