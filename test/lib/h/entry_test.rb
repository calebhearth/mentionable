require "test_helper"

class H::EntryTest < ActiveSupport::TestCase
  test "from_html parses complex h-card from html" do
    entry = H::Entry.from_html(File.read("test/fixtures/h-entry-complex.html"))

    assert_equal "Microformats are amazing", entry.name
    assert_equal Date.new(2013, 6, 13, 12), entry.published
    assert_equal Date.new(2013, 6, 14, 12), entry.updated
    assert_equal ["microformats"], entry.categories
    assert_equal "http://example.com/2013/06/microformats-are-amazing", entry.url
    assert_equal "http://example.com/2013/06/microformats-are-amazing", entry.uid
    assert_equal H::Card.new(properties: {
        name: ["London, UK"],
        "country-name": ["United Kingdom"],
      }), entry.location
    assert_equal ["https://other.example.com/2013/06/microformats-are-amazing"],
      entry.syndications
    assert_equal "http://example.com/reply-to", entry.in_reply_to
    assert_equal "YES", entry.rsvp
    assert_equal "http://example.com/like-of", entry.like_of
    assert_equal "http://example.com/repost-of", entry.repost_of
    assert_equal "A comment", entry.comments.first
    comment = entry.comments.last
    assert comment.class, H::Cite
    assert_equal Date.new(2013, 06, 14), comment.published
    assert_equal H::Card.new(properties: { name: ["Some One"] }), comment.author
    assert_equal "http://example.com/comment", comment.url
    assert_equal "Some One commented:", comment.name
    assert_equal("Another Comment", comment.content)
    assert_equal ["http://example.com/like"], entry.likes
    assert_equal "http://example.com/repost-of", entry.repost_of
    assert_equal ["http://example.com/repost"], entry.reposts
    assert_equal "http://example.com/bookmark-of", entry.bookmark_of
    assert_equal "http://example.com/translation-of", entry.translation_of
    assert_equal "http://example.com/listen-of", entry.listen_of
    assert_equal "http://example.com/watch-of", entry.watch_of
    assert_equal "http://example.com/read-of", entry.read_of
    assert_equal "http://example.com/like-of", entry.like_of
  end

  test "inspect omits empty values" do
    assert_match(
      /\A#<H::Entry:\d+ @name="My Article">\z/,
      H::Entry.new(properties: { "name" => ["My Article"] }).inspect,
    )
  end
end
