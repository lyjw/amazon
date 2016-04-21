require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do

  describe "#create" do

    let(:user) { FactoryGirl.create(:user) }
    let(:product) { FactoryGirl.create(:product) }

    context "user is signed in" do

      before { request.session[:user_id] = user.id }

      context "with valid parameters" do

        def valid_review
          post :create, product_id: product.id, review: FactoryGirl.attributes_for(:review, product_id: product.id, user_id: user.id)
        end

        it "adds a new review to the database" do
          count_before = product.reviews.count
          valid_review
          count_after = product.reviews.count

          expect(count_after).to eq(count_before + 1)
        end

        it "associates the review with the product" do
          valid_review
          expect(Review.last.product_id).to eq(product.id)
        end

        it "associates the review with the signed in user" do
          valid_review
          expect(Review.last.user_id).to eq(user.id)
        end

      end

      context "with invalid parameters" do

        def invalid_review
          post :create, product_id: product.id, review: FactoryGirl.attributes_for(:review, product_id: product.id, user_id: user.id, stars: 0)
        end

        it "renders the product show page" do
          invalid_review
          expect(response).to render_template("products/show")
        end
      end

    end

    context "user is not signed in" do
      before { request.session[:user_id] == nil }

      it "redirects to the sign in page" do
        post :create, product_id: product.id
        expect(response).to redirect_to new_session_path
      end
    end

  end

end
