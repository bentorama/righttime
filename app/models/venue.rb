class Venue < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy
  has_many :bookings, through: :events
  has_many :reviews, through: :bookings
  has_many_attached :photos

  # validates :address, :name, :description, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
