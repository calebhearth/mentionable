module Mentionable
  class Configuration
    # The Mentionable request verification job to use when a new webmention is
    # received. It is responsible for verifying the webmention per
    # https://www.w3.org/TR/webmention/#request-verification and then enqueuing
    # a {#persistence_job}.
    #
    # Defaults to {VerifyWithRouterJob}
    # @return [Class] Mentionable request verification job
    attr_accessor :request_verification_job

    # The Mentionable persistence job is used when a source and target have been
    # successfully verified to save the webmention. It should persist the
    # webmention and then enqueue a {#webmention_verification_job} with the
    # persisted record.
    #
    # Defaults to {SaveMentionJob}
    # @return [Class] Mentionable persistence job
    attr_accessor :persistence_job

    # The Mentionable webmention verification job to use when a new webmention is
    # received. It is responsible for verifying the webmention per
    # https://www.w3.org/TR/webmention/#webmention-verification and optionally
    # updating the {Mention} with a cache of the HTTP response and parsed
    # microformat data.
    #
    # Defaults to {ConfirmMentionJob}
    # @return [Class] Mentionable request verification job
    attr_accessor :webmention_verification_job

    def initialize
      @request_verification_job = Mentionable::VerifyWithRouterJob
      @persistence_job = Mentionable::SaveMentionJob
      @webmention_verification_job = Mentionable::ConfirmMentionJob
    end
  end

  # @return [Mentionable::Configuration] Mentionable's current config
  def self.config
    @config ||= Configuration.new
  end

  # Set Mentionable's config
  #
  # @param config [Mentionable::Configuration]
  def self.config=(config)
    @config = config
  end

  # Modify Mentionable's current config
  #
  # @yieldparam [Mentionable::Configuration] config current Mentionable config
  # ```
  # Mentionable.configure do |config|
  #   config.request_verification_job = Mentionable::VerifyWithRouterJob
  # end
  # ```
  def self.configure
    yield config
  end
end
