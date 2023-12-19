class GiftSuggestion < ApplicationRecord
  belongs_to :user
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 120 }
  validates :business, presence: true, length: { maximum: 20 }
  validates :hobby, presence: true, length: { maximum: 20 }
  validates :interest, presence: true, length: { maximum: 20 }
  validates :purpose, presence: true, length: { maximum: 20 }
  validates :relationship, presence: true, length: { maximum: 20 }
  validates :gender, presence: true
  enum gender: { man: 0, woman: 1, other: 2 }
end
