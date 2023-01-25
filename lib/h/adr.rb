class H::Adr
  include ActiveModel::AttributeAssignment

  attr_accessor :street_address
  attr_accessor :extended_address
  attr_accessor :post_office_box
  attr_accessor :locality
  attr_accessor :region
  attr_accessor :postal_code
  attr_accessor :country_name
  attr_accessor :label
  attr_accessor :geo
  attr_accessor :latitude
  attr_accessor :longitude
  attr_accessor :altitude
  attr_accessor :children

  def initialize(properties: nil, children: nil)
    if properties
      # name will be ignored per https://microformats.org/wiki/h-adr#:~:text=there%20is%20no%20%22p%2Dname%22%20property%20in%20h%2Dadr
      properties.delete(:name)
      assign_attributes(properties.to_h { |k, v| [k.to_s.underscore.to_sym, v.first] })
    end
    @children = children&.flat_map { H.parse([_1]) }
  end

  def ==(other)
    other.is_a?(self.class) && instance_values == other.instance_values
  end
end
