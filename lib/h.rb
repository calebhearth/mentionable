module H
  class << self
    def from_html(html)
      parse(Microformats.parse(html).to_h["items"])
    end

    def parse(items)
      items.map do |item|
        if item.is_a? String
          item
        else
          item = item.to_hash.with_indifferent_access
          case item[:type].first
          when "h-adr"
            H::Adr.new(properties: item[:properties], children: item[:children])
          when "h-card"
            H::Card.new(properties: item[:properties], children: item[:children])
          when "h-cite"
            H::Cite.new(properties: item[:properties], children: item[:children])
          when "h-entry"
            H::Entry.new(properties: item[:properties], children: item[:children])
          else
            item
          end
        end
      end
    end
  end
end

require "h/base"
require "h/adr"
require "h/card"
require "h/cite"
require "h/entry"
