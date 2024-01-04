class WishList < ApplicationRecord
  belongs_to :user
  validates :item_name, length: { maximum: 252 }, presence: true
  validates :description, length: { maximum: 252 }, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "item_name", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
end
