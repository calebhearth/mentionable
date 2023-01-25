module Mentionable
  class Mention < ApplicationRecord
    validates :target,
      presence: true,
      comparison: { other_than: :source, if: :source }
    validates :source, presence: true
    enum :status, [
      :target_not_recognized,
      :awaiting_verification,
      :verified,
      :failed,
    ].to_h { [_1, _1.to_s] }

    def microformat_items
      H.from_html(html)
    end
  end
end
