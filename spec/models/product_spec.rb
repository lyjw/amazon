require 'rails_helper'

RSpec.describe Product, type: :model do

  describe "validations" do

    it "must have a name and price" do
      a = Product.new
      a.valid?

      expect(a.errors).to have_key(:title)
      expect(a.errors).to have_key(:price)
      # expect { product.save }.to raise_error("ArgumentError")
    end

    it "must have a unique title" do
      a = Product.create(title: "Hello", description: "abcefghijkl", price: 10)
      b = Product.new(title: "Hello", description: "abcefghijkl", price: 15)
      b.valid?

      expect(b.errors).to have_key(:title)
    end

    it "must have a sale price or set sale price to price if no sale price is given" do
      a = Product.create(title: "Hello", description: "abcdefghijkl", price: 10)
      a.valid?

      expect(a.errors).not_to have_key(:sale_price)
      expect(a.sale_price).to eq(10)
    end

    it "must have a sale price less than or equal to price" do
      a = Product.create(title: "Hello", description: "abcdefghijkl", price: 5, sale_price: 10)
      a.valid?
      expect(a.errors).to have_key(:sale_price)
    end
  end

  describe ".on_sale?" do

    it "returns true if product is on sale" do
      a = Product.create(title: "Hello", description: "abcdefghijkl", price: 5, sale_price: 1)
      expect(a.on_sale?).to eq(true)
    end

    it "returns false if product is not on sale" do
      a = Product.create(title: "Hello", description: "abcdefghijkl", price: 5, sale_price: 5)
      expect(a.on_sale?).to eq(false)
    end
  end

end
