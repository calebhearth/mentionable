module Mentionable
  # Job to save a {Mention} with the provided source and target.
  # After persisting, a {Mentionable::Configuration#webmention_verification_job} is enqueued.
  class SaveMentionJob < ApplicationJob
    queue_as :default

    # @param source [String] source URL of the Webmention source
    # @param target [String] target URL of the Webmention target
    # @param valid [Boolean] whether the target URL was valid in
    #  {Mentionable::Configuration.verify_with_router_job
    #  Mentionable.config.verify_with_router_job}
    # @raise [ActiveRecord::RecordInvalid] if the {Mention} would be invalid
    #   with the given source and target inputs.
    def perform(source:, target:, valid:)
      mention = Mentionable::Mention.create!({
        source:,
        target:,
        status: valid ? :awaiting_verification : :target_not_recognized,
      })
      Mentionable.config.webmention_verification_job.perform_later(mention)
    end
  end
end
