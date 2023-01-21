require 'test_helper'
require 'minitest/mock'

module Mentionable
  class SaveMentionJobTest < ActiveJob::TestCase
    test 'saves a valid mention' do
      Mocktail.replace(Mentionable::ConfirmMentionJob)
      assert_changes(-> () { Mentionable::Mention.count }) do
        SaveMentionJob.perform_now('a source', 'a target')
      end
    end

    test 'kicks off a verification job' do
      Mocktail.replace(Mentionable::Mention)
      Mocktail.replace(Mentionable::ConfirmMentionJob)
      stubs { Mentionable::Mention.create!({ source: 'a source', target: 'a target' }) }
        .with { :a_mention }

      SaveMentionJob.perform_now('a source', 'a target')

      verify do
        Mentionable.config.webmention_verification_job
          .perform_later(:a_mention)
      end
    end

    test 'no persistence if source, target result in invalid mention' do
      assert_no_enqueued_jobs do
        assert_raises(ActiveRecord::RecordInvalid) do
          SaveMentionJob.perform_now('same', 'same')
        end
      end
    end
  end
end
