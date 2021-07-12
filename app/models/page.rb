class Page < ApplicationRecord
  belongs_to :document
  validates :text, presence: true, length: {minimum: 1, maximum: 280}
end
