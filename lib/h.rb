module H
  class << self
    def from_html(html)
      parse(Microformats.parse(html).to_h["items"])
    end

    def parse(items)
      items.map do |item|
        item = item.to_hash.with_indifferent_access
        case item[:type].first
        when "h-card"
          H::Card.new(properties: item[:properties], children: item[:children])
        when "h-adr"
          H::Adr.new(properties: item[:properties], children: item[:children])
        else
          item
        end
      end
    end
  end
end

require "h/adr"
require "h/card"
