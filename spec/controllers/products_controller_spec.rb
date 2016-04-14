require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  let(:product) { FactoryGirl.create(:product) }

  describe "#new" do
    before { get :new }

    it "renders the new template" do
      expect(response).to render_template(:new)
    end

    it "assigns a product to an instance variable" do
      expect(assigns(:product)).to be_a_new(Product)
    end
  end

  describe "#create" do

    context "given valid parameters" do

      def valid_request
        post :create, product: FactoryGirl.attributes_for(:product)
      end

      it "adds a new record to the Product database" do
        count_before = Product.count
        valid_request
        count_after = Product.count

        expect(count_after).to eq(count_before + 1)
      end

      it "redirects to the show template" do
        valid_request
        expect(response).to redirect_to(product_path(Product.last))
      end

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    context "given invalid parameters" do

      def invalid_request
        post :create, product: {description: ""}
      end

      it "does not add a record to the Product database" do
        count_before = Product.count
        invalid_request
        count_after = Product.count

        expect(count_after).to eq(count_before)
      end

      it "redirects to the new template" do
        invalid_request
        expect(response).to render_template :new
      end

      it "sets a flash message" do
        invalid_request
        expect(flash[:alert]).to be
      end

    end

  end

  describe "#destroy" do
    it "removes a record from the database" do
      product
      count_before = Product.count
      delete :destroy, id: product.id
      count_after = Product.count

      expect(count_after).to eq(count_before - 1)
    end

    it "redirects to the index template" do
      delete :destroy, id: product.id
      expect(response).to redirect_to(products_path)
    end

    it "sets a flash message" do
      delete :destroy, id: product.id
      expect(flash[:notice]).to be
    end
  end

  describe "#show" do

    before { get :show, id: product.id }

    it "renders the show template" do
      expect(response).to render_template(:show)
    end

    it "assigns a Product to an instance variable" do
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assigns all Products to an instance variable" do
      a = FactoryGirl.create(:product)
      b = FactoryGirl.create(:product)

      get :index
      expect(assigns(:products)).to eq([a, b])
    end
  end

end
