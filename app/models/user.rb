class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookings, dependent: :destroy
  has_many :venues, dependent: :destroy
  has_many :events, through: :venues
  has_many :reviews, through: :bookings
  has_many :orders

  after_initialize :set_defaults

  def set_defaults
    self.owner = false if owner.nil?
  end
end
