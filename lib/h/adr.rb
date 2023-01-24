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
    altitude: nil
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
