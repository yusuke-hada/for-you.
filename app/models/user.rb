class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :wish_lists, dependent: :destroy
  has_many :gift_suggestions, dependent: :destroy
  has_many :memos, dependent: :destroy
  has_many :message_cards, dependent: :destroy
  accepts_nested_attributes_for :wish_lists
  validates :name, length: { maximum: 252 }, presence: true
  VALID_EMAIL_REGEX = /\A[a-zA-Z0-9_+-]+(\.[a-zA-Z0-9_+-]+)*@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}\z/
  validates :email, { presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX } }
  validates :password, presence: true, length: { minimum: 5 },
                       if: lambda {
                             new_record? ||
                               changes[:crypted_password]
                           }
  validates :password, confirmation: true,
                       if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true,
                                    if: lambda {
                                      new_record? ||
                                        changes[:crypted_password] ||
                                        changes[:reset_password_token]
                                    }
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true
  validates :age, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 120 }
  validates :gender, presence: true
  validates :business, length: { maximum: 20 }
  validates :hobby, length: { maximum: 255 }
  enum gender: { man: 0, woman: 1, other: 2 }
  enum role: { general: 0, admin: 1 }
  scope :with_hobby, ->(hobby) { where('hobby @> ARRAY[?]::varchar[]', [hobby]) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[age business gender hobby]
  end
end
