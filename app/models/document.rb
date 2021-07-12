class Document < ApplicationRecord
  has_many :pages
  validates :title, presence: true, length: {minimum: 1, maximum: 50}
  validates :author, presence: true, length: {minimum: 1, maximum: 50}
  validates :dateCreated, presence: true

  validate :dateCreated_is_valid_datetime

  def happened_at_is_valid_datetime
    errors.add(:dateCreated, 'must be a valid datetime') if ((DateTime.parse(dateCreated) rescue ArgumentError) == ArgumentError)
  end
end
