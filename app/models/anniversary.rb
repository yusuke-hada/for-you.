class Anniversary < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 252 }
  validates :date, presence: true
  validates :description, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[title description date]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['user']
  end
end
