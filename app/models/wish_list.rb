class WishList < ApplicationRecord
  belongs_to :user
  validates :item_name, length: { maximum: 252 }, presence: true
  validates :description, length: { maximum: 252 }, presence: true
end
