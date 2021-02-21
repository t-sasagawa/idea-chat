class Room < ApplicationRecord
  # has_many :room_users
  belongs_to :user
  # has_many :users, through: :room_users

  validates :name, presence: true
end