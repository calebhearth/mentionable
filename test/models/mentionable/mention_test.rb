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

    def test_microformat_items
      assert_equal [H::Card.new(properties: {
        name: ["Jesse Cooke"],
        nickname: ["jc00ke"],
        photo: ["https://example.com/photo.jpeg"],
        url: ["https://example.com/@jc00ke", "https://example.com"],
        uid: [ "tag:example.com,2013:jc00ke"],
      })], Mention.new(html: File.read("test/fixtures/h-card.html"))
        .microformat_items
    end

    def valid_mention
      Mention.new(
        target: "https://www.example.com/target",
        source: "https://www.example.com/source",
      )
    end
  end
end
