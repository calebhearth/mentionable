require 'test_helper'
require 'minitest/mock'

module Mentionable
  class SaveMentionJobTest < ActiveJob::TestCase
    test 'saves a valid mention' do
      assert_changes(-> () { Mentionable::Mention.count }) do
        SaveMentionJob.perform_now('soure', 'target')
      end
    end

    test 'no persistence job if target is not a valid path' do
      assert_raises(ActiveRecord::RecordInvalid) do
        SaveMentionJob.perform_now('same', 'same')
      end
    end
  end
end
