require 'test_helper'

module Mentionable
  class MentionTest < ActiveSupport::TestCase
    def test_validation_target_presence
      subject = valid_mention
      subject.target = nil

      assert_not subject.valid?, "should not be valid without a target"
    end

    def test_validation_source_presence
      subject = valid_mention
      subject.source = nil

      assert_not subject.valid?, "should not be valid without a source"
    end

    def test_validation_target_different_than_source
      subject = valid_mention
      subject.source = subject.target

      assert_not subject.valid?, "should not be valid with same target and source"
    end

    def test_validation_valid
      assert valid_mention.valid?
    end

    def valid_mention
      Mention.new(
        target: "https://www.example.com/target",
        source: "https://www.example.com/source",
      )
    end
  end
end
