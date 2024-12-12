class BeerStyle < ApplicationRecord
  include RatingAverage
  include TopRatedN

  has_many :beers
  has_many :ratings, through: :beers
end
