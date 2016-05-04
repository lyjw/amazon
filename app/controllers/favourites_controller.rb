class FavouritesController < ApplicationController
  before_action :authenticate_user!
  before_action :product

  def create
    favourite = Favourite.new
    favourite.product = product
    favourite.user = current_user

    respond_to do |format|
      if favourite.save
        format.html { redirect_to product, notice: "Favourited!" }
        format.js   { render :create_success }
      else
        format.html { redirect_to product, notice: "Not added to Favourite." }
        format.js   { render :create_failure }
      end
    end
  end

  def destroy
    favourite.destroy

    respond_to do |format|
      format.html { redirect_to product, notice: "Removed from Favourites." }
      format.js   { render }
    end
  end

  private

  def product
    @product ||= Product.find params[:product_id]
  end

  def favourite
    @favourite ||= Favourite.find params[:id]
  end

end
