require 'test_helper'
require 'minitest/mock'

module Mentionable
  class VerifyWithRouterJobTest < ActiveJob::TestCase
    def setup
      @original_persistence_job = Mentionable.config.persistence_job
    end

    def teardown
      Mentionable.config.persistence_job = @original_persistence_job
    end

    test 'enqueues persistence job for target with path in Rails routes' do
      url = "/"
      Mentionable.config.persistence_job = Minitest::Mock.new
      Mentionable.config.persistence_job.expect :perform_later, true, [url, url]

      VerifyWithRouterJob.perform_now(url, url)

      Mentionable.config.persistence_job.verify
    end

    test 'no persistence job if target is not a valid path' do
      url = "https://www.example.com/not/a/path"
      assert_no_enqueued_jobs do
        VerifyWithRouterJob.perform_now(url, url)
      end
    end
  end
end
