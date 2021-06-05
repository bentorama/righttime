class Order < ApplicationRecord
  belongs_to :user
  belongs_to :event

  has_many :reviews, dependent: :destroy
  # validates :num_attendees, :total_cost, presence: true, numericality: { greater_than: 0 }
  monetize :amount_cents
end
