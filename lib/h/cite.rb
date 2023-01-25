class H::Cite < H::Base
  def self.attributes = %i[name published author url uid publication accessed content]
  def self.date_attributes = %i[published accessed]

  attr_accessor *attributes

  def initialize(properties:, children: nil)
    super
  end
end
