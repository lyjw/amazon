require 'rails_helper'

RSpec.feature "Products", type: :feature do

  let(:user) { FactoryGirl.create(:user) }
  before { login_with_web(user) }

  describe "with valid product data" do

    it "displays a create product heading on the page and redirects to the product show page after product creation" do
      category = FactoryGirl.create(:category)

      visit new_product_path

      valid_product = FactoryGirl.attributes_for(:product)

      fill_in "Title", with: valid_product[:title]
      fill_in "Description", with: valid_product[:description]
      fill_in "Price", with: valid_product[:price]
      select category.name, from: "Category"

      click_button "Create Product"

      expect(current_path).to eq(product_path(Product.last))
      expect(page).to have_text valid_product[:title]
    end

  end

  describe "with invalid product data" do
    it "stays on the new product page and displays an error message" do
      visit new_product_path

      click_button "Create Product"

      expect(current_path).to eq(products_path)
      expect(page).to have_text /can't be blank/i
    end
  end

end
