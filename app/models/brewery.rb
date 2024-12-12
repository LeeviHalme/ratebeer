class Brewery < ApplicationRecord
  include RatingAverage
  include TopRatedN

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, length: { minimum: 1 }
  validates :year, numericality: { only_integer: true, greater_than_or_equal_to: 1040 }
  validate :established_date_is_not_in_the_future

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  def established_date_is_not_in_the_future
    return unless year > Date.today.year

    errors.add(:expiration_date, "must be between 1040 and #{Date.today.year}")
  end

  def to_s
    name.to_s
  end
end
