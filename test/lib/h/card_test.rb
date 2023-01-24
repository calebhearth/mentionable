require "test_helper"

class H::CardTest < ActiveSupport::TestCase
  test "from_html parses an h-card from html" do
    card = H::Card.from_html(File.read("test/fixtures/h-card.html"))

    assert_equal "Jesse Cooke", card.name
    assert_equal "jc00ke", card.nickname
    assert_equal ["https://example.com/photo.jpeg"], card.photos
    assert_equal ["https://example.com/@jc00ke", "https://example.com"], card.urls
    assert_equal "tag:example.com,2013:jc00ke", card.uid
  end

  test "from_html parses complex h-card from html" do
    card = H::Card.from_html(File.read("test/fixtures/h-card-complex.html"))

    assert_equal "Sally Ride", card.name
    assert_equal "Dr.", card.honorific_prefix
    assert_equal "Sally", card.given_name
    assert_equal "K.", card.additional_name
    assert_equal "Ride", card.family_name
    assert_equal "Ph.D.", card.honorific_suffix
    assert_equal "sallykride", card.nickname
    assert_equal ["mailto:sally@example.com"], card.emails
    assert_equal "http://example.com/logo.png", card.logo
    assert_equal ["http://example.com/sk.jpg"], card.photos
    assert_equal ["http://sally.example.com"], card.urls
    assert_equal "http://example.com/sally", card.uid
    assert_equal ["physicist"], card.categories
    assert_equal [
      "1600 Pennsylvania Ave NW, Washington, DC 20500",
      H::Adr.new(
        street_address: "17 Austerstræti",
        locality: "Reykjavík",
        postal_code: "107",
        country_name: "Iceland"
      ),
    ], card.adrs
    assert_equal "123 Main st.", card.street_address
    assert_equal "Los Angeles", card.locality
    assert_equal "California", card.region
    assert_equal "91316", card.postal_code
    assert_equal "U.S.A", card.country_name
    assert_equal ["+1.818.555.1212"], card.tels
    assert_equal "First American woman in space.", card.note
    assert_equal Date.new(1951, 5, 26), card.bday
    assert_equal ["NASA"], card.orgs
    assert_equal "flight engineer", card.job_title
    assert_equal "astronaut", card.role
    assert_equal "xmpp:sally@example.com", card.impp
    assert_equal "female", card.sex
    assert_equal "female", card.gender_identity
    assert_equal Date.new(1983, 6, 18), card.anniversary
  end
end
