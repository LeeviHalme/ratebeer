class AddBeerStyleToBeers < ActiveRecord::Migration[7.0]
  def change
    add_reference :beers, :beer_style, null: false, foreign_key: true
  end
end
