class BeerStylesController < ApplicationController
  before_action :set_beer_style, only: %i[show edit update destroy]
  before_action :ensure_that_signed_in, except: [:index, :show]

  # GET /styles or /styles.json
  def index
    @beer_styles = BeerStyle.all
  end

  # GET /styles/1 or /styles/1.json
  def show
    @beer_style = BeerStyle.find(params[:id])
  end

  # GET /styles/1/edit
  def edit
  end

  # PATCH/PUT /styles/1 or /styles/1.json
  def update
    respond_to do |format|
      if @beer_style.update(beer_style_params)
        format.html { redirect_to @beer_style, notice: "Beer style was successfully updated." }
        format.json { render :show, status: :ok, location: @brewery }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @beer_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /styles/1 or /styles/1.json
  def destroy
    if !current_user.admin?
      redirect_to beer_style_path(@beer_style), notice: "Only admins can delete beer styles."
      return
    end

    @beer_style.destroy

    respond_to do |format|
      format.html { redirect_to beer_clubs_path, status: :see_other, notice: "Beer style was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_beer_style
    @beer_style = BeerStyle.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def beer_style_params
    params.require(:beer_style).permit(:name, :description)
  end
end
