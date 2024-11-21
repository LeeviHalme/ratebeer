class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }

  validates :password, length: { minimum: 4, message: "Password must be at least 4 characters long" }
  validates :password, format: { with: /\d.*[A-Z]|[A-Z].*\d/, message: "Password must contain at least one number and one capital letter" }
end
