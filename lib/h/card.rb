require "microformats"

class H::Card
  def self.attributes # :nodoc:
    [
      :name,
      :honorific_prefix,
      :given_name,
      :additional_name,
      :family_name,
      :sort_string,
      :honorific_suffix,
      :nickname,
      :emails,
      :logo,
      :photos,
      :urls,
      :uid,
      :categories,
      :adrs,
      :post_office_box,
      :extended_address,
      :street_address,
      :locality,
      :region,
      :postal_code,
      :country_name,
      :label,
      :geo,
      :latitude,
      :longitude,
      :altitude,
      :tels,
      :note,
      :bday,
      :key,
      :orgs,
      :job_title,
      :role,
      :impp,
      :sex,
      :gender_identity,
      :anniversary,
      :children,
    ]
  end

  attributes.each { attr_reader _1 }

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
    plural_attributes = %i[emails photos urls categories adrs tels orgs]
    date_attributes = %i[bday anniversary]
    special_attributes =  [:adrs, :children]
    singular_attributes = self.class.attributes - plural_attributes - date_attributes

    plural_attributes.each do |attribute|
      instance_variable_set("@#{attribute}", properties[attribute.to_s.singularize.dasherize])
    rescue NoMethodError => e
      binding.irb
    end
    singular_attributes.each do |attribute|
      instance_variable_set("@#{attribute}", properties[attribute.to_s.dasherize]&.first)
    end
    date_attributes.each do |attribute|
      if (date = properties[attribute]&.first)
        instance_variable_set("@#{attribute}", Date.parse(date))
      end
    end
    @adrs = properties[:adr]&.map do |adr|
      if adr.is_a?(Hash)
        H::Adr.new(properties: adr[:properties], children: adr[:children])
      else
        adr
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
    other.is_a?(H::Card) && instance_values == other.instance_values
  end
end
