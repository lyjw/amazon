require 'rails_helper'

RSpec.feature "UserSignUps", type: :feature do
  describe "with valid user data" do

    it "redirects the user to the home page, sets a flash message and shows the user name on the page" do

      visit new_user_path

      valid_attributes = FactoryGirl.attributes_for(:user)

      fill_in "First Name", with: valid_attributes[:first_name]
      fill_in "Last Name", with: valid_attributes[:last_name]
      fill_in "Email", with: valid_attributes[:email]
      fill_in "Password", with: valid_attributes[:password]
      fill_in "Password Confirmation", with: valid_attributes[:password]

      click_button "Create an Account"

      full_name = "#{valid_attributes[:first_name]} #{valid_attributes[:last_name]}"

      expect(page).to have_text /#{full_name}/i

      expect(current_path).to eq(root_path)

      expect(page).to have_text /user created./i
    end
  end

  describe "invalid user data" do
    it "stays on the sign up page and sets error messages" do
      visit new_user_path

      click_button "Create an Account"

      expect(page).to have_text /can't be blank/i
      expect(current_path).to eq(users_path)
    end
  end
end
