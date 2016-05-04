class LikesController < ApplicationController
  before_action :review

  def create
    like = Like.new
    like.review = review
    like.user = current_user

    respond_to do |format|
      if like.save
        format.html { redirect_to product_path(review.product_id), notice: "Liked!" }
        format.js { render }
      else
        format.html { redirect_to product_path(review.product_id), notice: "Already liked!" }
      end
    end
  end

  def destroy
    like.destroy

    respond_to do |format|
      format.html { redirect_to product_path(review.product_id), notice: "Unliked." }
      format.js { render }
    end
  end

  private

  def like
    @like ||= Like.find params[:id]
  end

  def review
    @review ||= Review.find params[:review_id]
  end

end
