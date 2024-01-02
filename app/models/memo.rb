class Memo < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 252 }
  validates :goods, presence: true, length: { maximum: 252 }
end
