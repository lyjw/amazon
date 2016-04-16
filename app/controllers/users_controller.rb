class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit([:first_name, :last_name, :email, :password, :password_controller])
    @user = User.new user_params

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "User created."
    else
      flash[:alert] = "Invalid. User not created."
      render :new
    end
  end

  def show
    @products = Product.where(['user_id = ?', current_user.id])
    @reviews = Review.where(['user_id = ?', current_user.id])
  end
end
