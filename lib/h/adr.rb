H::Adr = Data.define(
  :street_address,
  :extended_address,
  :post_office_box,
  :locality,
  :region,
  :postal_code,
  :country_name,
  :label,
  :geo,
  :latitude,
  :longitude,
  :altitude,
) do
  def self.from_properties(properties)
    new(**properties.to_h { |k, v| [k.underscore.to_sym, v.first] })
  end

  def initialize(
    street_address: nil,
    extended_address: nil,
    post_office_box: nil,
    locality: nil,
    region: nil,
    postal_code: nil,
    country_name: nil,
    label: nil,
    geo: nil,
    latitude: nil,
    longitude: nil,
    altitude: nil,
    name: nil # will be ignored per https://microformats.org/wiki/h-adr#:~:text=there%20is%20no%20%22p%2Dname%22%20property%20in%20h%2Dadr
  )
    super(
      street_address:,
      extended_address:,
      post_office_box:,
      locality:,
      region:,
      postal_code:,
      country_name:,
      label:,
      geo:,
      latitude:,
      longitude:,
      altitude:,
    )
  end
end
