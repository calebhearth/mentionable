require 'test_helper'
require 'minitest/mock'

module Mentionable
  class SaveMentionJobTest < ActiveJob::TestCase
    test 'saves a valid mention' do
      Mocktail.replace(Mentionable::ConfirmMentionJob)
      assert_changes(-> () { Mentionable::Mention.awaiting_verification.count }) do
        SaveMentionJob.perform_now(source: 'a source', target: 'a target', valid: true)
      end
    end

    test 'saves an invalid mention' do
      Mocktail.replace(Mentionable::ConfirmMentionJob)
      assert_changes(-> () { Mentionable::Mention.target_not_recognized.count }) do
        SaveMentionJob.perform_now(source: 'a source', target: 'a target', valid: false)
      end
    end

    test 'kicks off a verification job' do
      source = 'a source'
      target = 'a target'
      status = :awaiting_verification
      Mocktail.replace(Mentionable::Mention)
      stubs { Mentionable::Mention.create!({ source:, target:, status: }) }
        .with { :a_mention }

      assert_enqueued_with(job: Mentionable::ConfirmMentionJob, args: [:a_mention]) do
        SaveMentionJob.perform_now(source:, target:, valid: true)
      end
    end

    test 'no persistence if source, target result in invalid mention' do
      assert_no_enqueued_jobs do
        assert_raises(ActiveRecord::RecordInvalid) do
          SaveMentionJob.perform_now(source: 'same', target: 'same', valid: true)
        end
      end
    end
  end
end
