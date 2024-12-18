class RatingsController < ApplicationController
  def index
    @ratings = Rating.recent
    @top_beers = Beer.top_rated 3
    @top_breweries = Brewery.top_rated 3
    @top_styles = BeerStyle.top_rated 3
    @most_active_users = User.most_active 3
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user

    if @rating.save
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    rating = Rating.find params[:id]
    rating.delete if current_user == rating.user
    redirect_to user_path(current_user)
  end
end
