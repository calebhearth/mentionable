class DifferentThanValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    other = options.fetch(:other)
    if value == record.public_send(other)
      record.errors.add attribute, :not_different, other: other
    end
  end
end
module Mentionable
  class Mention < ApplicationRecord
    validates :target, presence: true, different_than: { other: :source }
    validates :source, presence: true
  end
end
