class Memo < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 252 }
  validates :goods, presence: true, length: { maximum: 252 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[name goods time]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['user']
  end
end
