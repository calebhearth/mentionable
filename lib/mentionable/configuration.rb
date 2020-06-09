module Mentionable
  class Configuration
    # The Mentionable verification job to use when a new webmention is received.
    #
    # Defaults to {VerifyWithRouterJob}
    # @return Mentionable verification job
    attr_accessor :verification_job

    # The Mentionable persistence job is used when a source and target have been
    # successfully verified to save the webmention.
    #
    # Defaults to {UpsertWebmentionJob}
    # @return Mentionable persistence job
    attr_accessor :persistence_job

    def initialize
      @verification_job = Mentionable::VerifyWithRouterJob
      @persistence_job = nil
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
  #   config.verification_job = Mentionable::VerifyWithRouterJob
  # end
  # ```
  def self.configure
    yield config
  end
end
