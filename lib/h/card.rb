require "microformats"

class H::Card < H::Base
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

  def self.plural_attributes = %i[emails photos urls categories adrs tels orgs]
  def self.date_attributes = %i[bday anniversary]

  attributes.each { attr_reader _1 }
end
