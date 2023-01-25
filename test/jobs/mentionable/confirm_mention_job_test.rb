require 'test_helper'
require 'net/http'

class Mentionable::ConfirmMentionJobTest < ActiveJob::TestCase
  test 'checks that the body at url mention.source contains mention.target' do
    Mocktail.replace(Net::HTTP)
    mention = Mentionable::Mention.new(
      target: "https://example.com/target",
      source: "https://example.com/source",
      status: "awaiting_verification",
    )
    html = %(<p>
      some text that includes
      <a href="#{mention.target}">a link</a>
      and then more text
    </p>)
    stubs { Net::HTTP.get(URI(mention.source)) }.with { html }

    Mentionable::ConfirmMentionJob.perform_now(mention, cache: true)
    assert_equal html, mention.html
    assert_equal "verified", mention.status
  end

  test 'does not cache body when cache is false' do
    Mocktail.replace(Net::HTTP)
    mention = Mentionable::Mention.new(
      target: "https://example.com/target",
      source: "https://example.com/source",
      status: "awaiting_verification",
    )
    html = %(<p>
      some text that includes
      <a href="#{mention.target}">a link</a>
      and then more text
    </p>)
    stubs { Net::HTTP.get(URI(mention.source)) }.with { html }

    Mentionable::ConfirmMentionJob.perform_now(mention, cache: false)
    assert_nil mention.html
    assert_equal "verified", mention.status
  end

  test 'sets status to failed when mention.source does not link to mention.target' do
    Mocktail.replace(Net::HTTP)
    mention = Mentionable::Mention.new(
      target: "https://example.com/target",
      source: "https://example.com/source",
      status: "awaiting_verification",
    )
    html = %(<p>does not link to target</p>)
    stubs { Net::HTTP.get(URI(mention.source)) }.with { html }

    Mentionable::ConfirmMentionJob.perform_now(mention, cache: true)
    assert_equal html, mention.html
    assert_equal "failed", mention.status
  end
end
