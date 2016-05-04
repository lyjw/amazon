module FavouritesHelper

  def user_favourite(product)
    # Returns a Favourite object
    @user_favourite ||= product.favourite_of(current_user)
  end

end
