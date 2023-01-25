require "microformats"

class H::Card
  attr_reader :name
  attr_reader :honorific_prefix
  attr_reader :given_name
  attr_reader :additional_name
  attr_reader :family_name
  attr_reader :sort_string
  attr_reader :honorific_suffix
  attr_reader :nickname
  attr_reader :emails
  attr_reader :logo
  attr_reader :photos
  attr_reader :urls
  attr_reader :uid
  attr_reader :categories
  attr_reader :adrs
  attr_reader :post_office_box
  attr_reader :extended_address
  attr_reader :street_address
  attr_reader :locality
  attr_reader :region
  attr_reader :postal_code
  attr_reader :country_name
  attr_reader :label
  attr_reader :geo
  attr_reader :latitude
  attr_reader :longitude
  attr_reader :altitude
  attr_reader :tels
  attr_reader :note
  attr_reader :bday
  attr_reader :key
  attr_reader :orgs
  attr_reader :job_title
  attr_reader :role
  attr_reader :impp
  attr_reader :sex
  attr_reader :gender_identity
  attr_reader :anniversary
  attr_reader :children

  def self.from_html(html)
    new(
      Microformats
        .parse(html)
        .items
        .first
        .to_hash
        .with_indifferent_access
    )
  end

  def initialize(card_hash)
    @name = card_hash[:properties][:name]&.first
    @honorific_prefix = card_hash[:properties][:"honorific-prefix"]&.first
    @given_name = card_hash[:properties][:"given-name"]&.first
    @additional_name = card_hash[:properties][:"additional-name"]&.first
    @family_name = card_hash[:properties][:"family-name"]&.first
    @honorific_suffix = card_hash[:properties][:"honorific-suffix"]&.first
    @nickname = card_hash[:properties][:nickname]&.first
    @emails = card_hash[:properties][:email]
    @logo = card_hash[:properties][:logo]&.first
    @photos = card_hash[:properties][:photo]
    @urls = card_hash[:properties][:url]
    @uid = card_hash[:properties][:uid]&.first
    @categories = card_hash[:properties][:category]
    @adrs = card_hash[:properties][:adr]&.map do |adr|
      if adr.is_a?(Hash)
        H::Adr.from_properties(adr[:properties])
      else
        adr
      end
    end
    @street_address = card_hash[:properties][:"street-address"]&.first
    @locality = card_hash[:properties][:locality]&.first
    @region = card_hash[:properties][:region]&.first
    @postal_code = card_hash[:properties][:"postal-code"]&.first
    @country_name = card_hash[:properties][:"country-name"]&.first
    @tels = card_hash[:properties][:tel]
    @note = card_hash[:properties][:note]&.first
    @bday = (date = card_hash[:properties][:bday]&.first)  && Date.parse(date)
    @orgs = card_hash[:properties][:org]
    @job_title = card_hash[:properties][:"job-title"]&.first
    @role = card_hash[:properties][:role]&.first
    @impp = card_hash[:properties][:impp]&.first
    @sex = card_hash[:properties][:sex]&.first
    @gender_identity = card_hash[:properties][:"gender-identity"]&.first
    @anniversary = (date = card_hash[:properties][:anniversary]&.first) && Date.parse(date)
    @children = card_hash[:children]&.flat_map { H.parse([_1]) }
  end
end
