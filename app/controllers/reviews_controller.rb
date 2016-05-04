class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_product, only: [:create, :destroy]

  def create
    review_params = params.require(:review).permit([:stars, :body])
    @review = Review.new(review_params)
    @review.product = @product
    @review.user = current_user

    respond_to do |format|
      if @review.save
        format.html { redirect_to product_path(@product), notice: "Product created." }
        format.js { render :create_success }
      else
        flash[:alert] = "Product not created."
        format.html { render "products/show" }
        format.js { render :create_failure }
      end
    end
  end

  def destroy
    @review = @product.reviews.find params[:id]
    @review.destroy

    respond_to do |format|
      format.html { redirect_to product_path(@product), notice: "Review deleted." }
      format.js { render }
    end
  end

  private

  def find_product
    @product = Product.find params[:product_id]
  end

end
