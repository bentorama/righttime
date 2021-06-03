class Venue < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy
  has_many :bookings, through: :events
  has_many :reviews, through: :bookings
  has_one_attached :photo

  validates :address, :name, :description, presence: true
end
