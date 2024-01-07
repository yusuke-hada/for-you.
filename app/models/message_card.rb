class MessageCard < ApplicationRecord
  belongs_to :user
  validates :recipient_name, presence: true, length: { maximum: 20 }
  validates :message, presence: true, length: { maximum: 252 }
  validates :background_image, presence: true
end
