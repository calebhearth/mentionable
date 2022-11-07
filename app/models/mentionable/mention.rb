module Mentionable
  class Mention < ApplicationRecord
    validates :target,
      presence: true,
      comparison: { other_than: :source, if: :source }
    validates :source, presence: true
  end
end
