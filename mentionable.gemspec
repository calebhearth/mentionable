$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "mentionable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "mentionable"
  spec.version     = Mentionable::VERSION
  spec.authors     = ["Caleb Hearth"]
  spec.email       = ["caleb@calebhearth.com"]
  spec.homepage    = "https://github.com/calebthompson/mentionable"
  spec.summary     = "Webmentions on Rails"
  spec.description = "Webmention sending and receiving for Rails projects."
  spec.license     = "Hippocratic 2.1"

  spec.files = Dir["{app,config,db,lib}/**/*", "LICENSE.md", "Rakefile", "README.md"]

  spec.add_dependency "activejob"
  spec.add_dependency "activemodel"
  spec.add_dependency "activerecord"
  spec.add_dependency "activesupport"
  spec.add_dependency "railties"

  spec.add_development_dependency "pg"
end
