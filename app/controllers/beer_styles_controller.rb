class BeerStylesController < ApplicationController
  # GET /styles or /styles.json
  def index
    @beer_styles = BeerStyle.all
  end

  # GET /styles/1 or /styles/1.json
  def show
    @beer_style = BeerStyle.find(params[:id])
  end
end
