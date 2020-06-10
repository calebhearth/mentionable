module Mentionable
  # Job to save a Mentionable::Mention with the provided source and target.
  class SaveMentionJob < ApplicationJob
    queue_as :default

    def perform(source, target)
      Mentionable::Mention.create!(source: source, target: target)
    end
  end
end
