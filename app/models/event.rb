class Event < ApplicationRecord
  belongs_to :venue
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings
  has_many_attached :photos

  validates :starting_price, :start_time, :description, :name, :num_tickets, :duration, :min_price, presence: true
  validates :starting_price, :num_tickets, :min_price, numericality: { greater_than: 0 }

  include PgSearch::Model
    pg_search_scope :search_events_pg,
      against: [ :name ],
      using: {
        tsearch: { prefix: true } # <-- partial words allowed
      }
end
