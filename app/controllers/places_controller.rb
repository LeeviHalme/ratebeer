class PlacesController < ApplicationController
  before_action :set_place, only: :show

  def index
  end

  def show
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    session[:last_search] = params[:city]
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      @weather = WeatherstackApi.weather_in(params[:city])
      render :index, status: 418
    end
  end

  private

  def set_place
    if session[:last_search].nil?
      redirect_to places_path, notice: "You should first search for a city"
      return
    end

    @places = BeermappingApi.places_in(session[:last_search])

    if @places.empty?
      redirect_to places_path, notice: "Couldn't find that place in #{params[:city]}"
    else
      @place = @places.find { |place| place.id == params[:id] }

      if @place.nil?
        redirect_to places_path, notice: "Couldn't find that place in #{params[:city]}"
      end
    end
  end
end