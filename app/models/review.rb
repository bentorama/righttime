class Review < ApplicationRecord
  belongs_to :booking

  validates :event_review, presence: true
  # validates :venue_rating, inclusion: { in: [1..5] }
  validates :venue_rating, inclusion: { in: 1..5 }, numericality: { only_integer: true }
end
