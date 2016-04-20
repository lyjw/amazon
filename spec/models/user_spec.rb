require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do

    it "requires a first name" do
      u = User.new FactoryGirl.attributes_for(:user, first_name: nil)
      expect(u).to be_invalid
    end

    it "requires a last name" do
      u = User.new FactoryGirl.attributes_for(:user, last_name: nil)
      expect(u).to be_invalid
    end

    it "requires an email" do
      u = User.new FactoryGirl.attributes_for(:user, email: nil)
      expect(u).to be_invalid
    end
  end

  describe ".full_name" do
    it "must return titleized first name and last name concatenated" do
      u = User.new FactoryGirl.attributes_for(:user,
                              first_name: "john", last_name: "smith")
      expect(u.full_name).to eq("John Smith")
    end
  end
end
