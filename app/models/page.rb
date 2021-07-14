class Page < ApplicationRecord
  belongs_to :document
  validates :text, presence: true, length: {minimum: 1, maximum: 280}
  validates :pageNr, presence: true, numericality: { only_integer: true }
  validates :document_id, presence: true
end
