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

  def favorite_beer
    return nil if ratings.empty?

    ratings.max_by(&:score).beer
  end

  def favorite_style
    return nil if ratings.empty?

    style_ratings = ratings.group_by { |r| r.beer.beer_style.name }
    style_ratings.max_by { |_style, ratings| ratings.map(&:score).sum / ratings.count }.first
  end

  def favorite_brewery
    return nil if ratings.empty?

    brewery_ratings = ratings.group_by { |r| r.beer.brewery }
    brewery_ratings.max_by { |_brewery, ratings| ratings.map(&:score).sum / ratings.count }.first
  end

  def self.most_active(n_elements)
    User.all.sort_by { |u| -u.ratings.count }.take(n_elements)
  end

  def to_s
    username
  end
end
