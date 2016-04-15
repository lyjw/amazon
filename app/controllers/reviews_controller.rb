class ReviewsController < ApplicationController

  def create
    @product = Product.find params[:product_id]
    review_params = params.require(:review).permit([:stars, :body])
    @review = Review.new(review_params)
    @review.product = @product

    if @review.save
      redirect_to product_path(@product), notice: "Product created."
    else
      flash[:alert] = "Product not created."
      render "/products/show"
    end
  end

  def destroy
    product = Product.find params[:product_id]
    review = product.reviews.find params[:id]
    review.destroy

    redirect_to product_path(product), notice: "Review deleted."
  end

end
