class UpdateBeersWithBeerStyle < ActiveRecord::Migration[7.0]
  def up
    Beer.find_each do |beer|
      style = BeerStyle.find_by(name: beer.old_style)
      beer.update(beer_style: style) if style
    end
  end

  def down
    Beer.update_all(beer_style_id: nil)
  end
end
