require "microformats"

class H::Base
  def self.plural_attributes = [] # :nodoc:
  def self.date_attributes = [] # :nodoc:
  def self.special_attributes = [] # :nodoc:

  def self.from_html(html)
    h = Microformats
      .parse(html)
      .items
      .first
      .to_hash
    new(properties: h["properties"], children: h["children"])
  end

  def initialize(properties:, children: nil)
    properties = properties&.with_indifferent_access
    children = children&.map(&:with_indifferent_access)
    singular_attributes = self.class.attributes -
      self.class.plural_attributes -
      self.class.date_attributes -
      self.class.special_attributes

    self.class.plural_attributes.each do |attribute|
      if (items = properties[attribute.to_s.singularize.dasherize])
        instance_variable_set("@#{attribute}", H.parse(items))
      end
    end
    singular_attributes.each do |attribute|
      if (item = properties[attribute.to_s.dasherize]&.first)
        instance_variable_set("@#{attribute}", H.parse([item]).first)
      end
    end
    self.class.date_attributes.each do |attribute|
      if (date = properties[attribute]&.first)
        instance_variable_set("@#{attribute}", Date.parse(date))
      end
    end
    @children = children&.flat_map { H.parse([_1]) }
  end

  def inspect
    attr_strings = self
      .class
      .attributes
      .filter_map { (value = instance_variable_get("@#{_1}")) && " @#{_1}=#{value.inspect}" }
      .join(",")
    %[#<#{self.class.name}:#{object_id}#{attr_strings}>]
  end

  def ==(other)
    other.is_a?(self.class) && instance_values == other.instance_values
  end
end
