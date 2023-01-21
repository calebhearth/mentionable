module Mentionable
  # Job to save a {Mention} with the provided source and target.
  # After persisting, a {Mentionable::Configuration#webmention_verification_job} is enqueued.
  class SaveMentionJob < ApplicationJob
    queue_as :default

    # @param [String] source URL of the Webmention source
    # @param [String] target URL of the Webmention target
    # @raise [ActiveRecord::RecordInvalid] if the {Mention} would be invalid
    #   with the given source and target inputs.
    def perform(source, target)
      mention = Mentionable::Mention.create!({ source: source, target: target })
      Mentionable.config.webmention_verification_job.perform_later(mention)
    end
  end
end
