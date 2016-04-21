class FavouritesController < ApplicationController
  before_action :authenticate_user!

  def create
    favourite = Favourite.new
    favourite.product = product
    favourite.user = current_user

    if favourite.save
      redirect_to product, notice: "Favourited!"
    else
      redirect_to product, notice: "Not added to Favourite."
    end
  end

  def destroy
    favourite.destroy
    redirect_to product, notice: "Removed from Favourites."
  end

  private

  def product
    @product ||= Product.find params[:product_id]
  end

  def favourite
    @favourite ||= Favourite.find params[:id]
  end

end
