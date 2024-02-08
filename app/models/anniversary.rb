class Anniversary < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 252 }
  validates :date, presence: true
  validates :description, presence: true
end
