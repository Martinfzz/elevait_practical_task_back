class Document < ApplicationRecord
  has_many :pages
  validates :title, presence: true, length: {minimum: 1, maximum: 50}
  validates :author, presence: true, length: {minimum: 1, maximum: 50}
  validates :dateCreated, presence: true
end
