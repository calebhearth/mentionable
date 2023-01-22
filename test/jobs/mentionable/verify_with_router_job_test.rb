require 'test_helper'
require 'minitest/mock'

module Mentionable
  class VerifyWithRouterJobTest < ActiveJob::TestCase
    test 'enqueues valid persistence job for target with path in Rails routes' do
      url = "/"
      assert_enqueued_with(
        job: Mentionable::SaveMentionJob,
        args: [source: url, target: url, valid: true],
      ) do
        VerifyWithRouterJob.perform_now(url, url)
      end
    end

    test 'valid false if target is not a valid path' do
      url = "https://www.example.com/not/a/path"
      assert_enqueued_with(
        job: Mentionable::SaveMentionJob,
        args: [source: url, target: url, valid: false],
      ) do
        VerifyWithRouterJob.perform_now(url, url)
      end
    end
  end
end
