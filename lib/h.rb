module H
  class << self
    def from_html(html)
      parse(Microformats.parse(html).items)
    end

    def parse(items)
      items.map do |item|
        item = item.to_hash.with_indifferent_access
        case item[:type].first
        when "h-card"
          H::Card.new(item)
        when "h-adr"
          H::Adr.from_properties(item[:properties])
        else
          item
        end
      end
    end
  end
end

require "h/adr"
require "h/card"
