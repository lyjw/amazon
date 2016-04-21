require 'rails_helper'

RSpec.describe User, type: :model do

  def attributes_user(new_attributes = {})
    { first_name: "John", last_name: "Smith", email: "john@smith.com", password: "secret" }.merge(new_attributes)
  end

  describe "validations" do

    it "requires a first name" do
      u = User.new attributes_user(first_name: nil)
      # u = User.new FactoryGirl.attributes_for(:user, first_name: nil)
      expect(u).to be_invalid
    end

    it "requires a last name" do
      u = User.new FactoryGirl.attributes_for(:user, last_name: nil)
      expect(u).to be_invalid
    end

    it "requires email to be unique" do
      u = FactoryGirl.create(:user, email: "test@email.com")
      u2 = User.new FactoryGirl.attributes_for(:user, email: u.email)
      expect(u2).to be_invalid
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
