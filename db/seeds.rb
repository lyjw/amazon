# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

all_categories = Category.all

# Seed with Users
10.times do
  u = FactoryGirl.create(:user)

  # Seed with Products
  5.times do
    a = FactoryGirl.build(:product)

    random = rand(20)
    a.sale_price = if random < 10
      # Generates sale products
      rand(0.01..Faker::Commerce.price)
    else
      # Generates products not on sale
      Faker::Commerce.price
    end

    a.save

    3.times do
      r = FactoryGirl.create(:review)
      r.user = u
      r.save
      a.reviews.push(r)
    end

    # Assigs a random category to each product
    random_category = all_categories.sample
    a.category = random_category
    a.user = u
    a.save
  end
end



# Seed with Reviews

# Seed with Categories
# 10.times do
#   Category.create(name: Faker::Commerce.department)
# end
