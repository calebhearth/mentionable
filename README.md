# Mentionable

An implementation of [Webmention], a web standard for mentions and conversyions
across the web. With mentionable, people can reply by sending webmentions for:

[Webmention]: <https://www.w3.org/TR/webmention/> "Webmention W3C Recommendation"

- commenting
- liking
- reposting
- mentioning / linking to
- quote

The `h-entry` specification provides for more types of reply, but these are what
Mentionable currently supports.

Mentionable sets up an endpoint in your Rails app to receive these Webmentions,
confirms that the reply actually links back to a page you've published, and
stores replies in the database for you to display or use as you please.

Optionally, Mentionable can be configured to send Webmentions when content you
create links to external sites. It does this by querying the link, performing
[Webmention endpoint discovery], and notifying sites that are set up to receive
Webmentions.

[Webmention endpoint discovery]: <https://www.w3.org/TR/webmention/#sender-discovers-receiver-webmention-endpoint>

You can configure one or more objects to be queried upon creation by telling
Mentionable what they are and what method to check for links.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'hearthside-mentionable', require: 'mentionable'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install hearthside-mentionable
```

## Contributing
Contribution directions go here.

## License

See LICENSE.md
