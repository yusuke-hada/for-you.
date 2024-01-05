class WishList < ApplicationRecord
  belongs_to :user
  validates :item_name, length: { maximum: 252 }, presence: true
  validates :description, length: { maximum: 252 }, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["description", "item_name"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
end
