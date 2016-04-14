FactoryGirl.define do
  factory :product do
    sequence(:title)  { |n| "#{Faker::Commerce.product_name}" }
    description       { "#{Faker::Hipster.paragraph}" }
    price             { 11 + rand(10000) }
    sale_price        { rand(price) }
  end
end
