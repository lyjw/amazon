require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#new" do

    before { get :new }

    it "renders the new template" do
      expect(response).to render_template(:new)
    end

    it "sets a User instance variable" do
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "#create" do

    context "with valid parameters" do

      def valid_request
        post :create, user: FactoryGirl.attributes_for(:user)
      end

      it "creates a User in the database" do
        count_before = User.count
        valid_request
        count_after = User.count

        expect(count_after).to eq(count_before + 1)
      end

      it "redirects to the home page" do
        valid_request
        expect(response).to redirect_to(root_path)
      end

      it "signs the user in" do
        valid_request
        expect(session[:user_id]).to eq(User.last.id)
      end
    end

    context "with invalid parameters" do

      def invalid_request
        post :create, user: FactoryGirl.attributes_for(:user, first_name: nil)
      end

      it "does not create a User in the database" do
        count_before = User.count
        invalid_request
        count_after = User.count

        expect(count_after).to eq(count_before)
      end

      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end
    end
  end
end
