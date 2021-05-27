class Event < ApplicationRecord
  belongs_to :venue
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings

  validates :starting_price, :start_time, :description, :name, :num_tickets, :duration, :min_price, presence: true
  validates :starting_price, :num_tickets, :min_price, numericality: { greater_than: 0 }
end
