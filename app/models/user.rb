class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  # has_many :bookings, dependent: :destroy
  has_many :venues, dependent: :destroy
  has_many :events, through: :venues
  has_many :reviews, through: :bookings
  has_many :orders, dependent: :destroy
  has_many :favourites, dependent: :destroy

  after_initialize :set_defaults

  def set_defaults
    self.owner = false if owner.nil?
  end

  # def avatar_thumbnail
  #   avatar.variant(resize: "105x150!").processed if current_user.avatar.attached?
  # end
end
