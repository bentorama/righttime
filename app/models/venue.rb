class Venue < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy
  has_many :bookings, through: :events
  has_many :reviews, through: :bookings

  validates :address, :name, :description, presence: true
end
