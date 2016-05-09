require 'rails_helper'

RSpec.feature "UserSignins", type: :feature do

  let(:user) { FactoryGirl.create(:user) }

  describe "with correct credentials" do

    it "redirects the user to the home page and shows the user's name" do
      visit new_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Sign In"

      expect(current_path).to eq(root_path)
      expect(page).to have_text("#{user.full_name}")
    end
  end

  describe "with wrong credentials" do

    it "stays on the sign in page and does not show the user's name" do
      visit new_session_path

      click_button "Sign In"

      expect(current_path).to eq(sessions_path)
      expect(page).to_not have_text("#{user.full_name}")
    end
  end

end
