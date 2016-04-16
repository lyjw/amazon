FactoryGirl.define do
  factory :product do
    sequence(:title)  { |n| "#{Faker::Commerce.product_name}" }
    description       { "#{Faker::Hipster.sentence}" }
    price             { 11 + rand(10000) }
  end
end
