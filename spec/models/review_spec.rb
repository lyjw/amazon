require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "validations" do

    it "requires star count" do
      r = Review.new FactoryGirl.attributes_for(:review, stars: nil)
      expect(r).to be_invalid
    end

    it "has a star count between 1 and 5 inclusive" do
      r = Review.new FactoryGirl.attributes_for(:review, stars: 0)
      expect(r).to be_invalid
    end

  end
end
