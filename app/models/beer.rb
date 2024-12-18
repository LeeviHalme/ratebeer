class Beer < ApplicationRecord
  include RatingAverage
  include TopRatedN

  belongs_to :brewery
  belongs_to :beer_style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  validates :name, length: { minimum: 1 }

  def to_s
    "#{name} - #{brewery.name}"
  end
end
