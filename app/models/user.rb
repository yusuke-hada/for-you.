class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :wish_lists, dependent: :destroy
  accepts_nested_attributes_for :wish_lists
  validates :name, length: { maximum: 252 }, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: lambda {
                                                          new_record? || changes[:crypted_password] || changes[:reset_password_token]
                                                        }
  # validates :reset_password_token, uniqueness: true, allow_nil: true
  validates :age, presence: true
  validates :gender, presence: true
  enum gender: { man: 0, woman: 1, other: 2 }
  enum role: { general: 0, admin: 1 }
end
