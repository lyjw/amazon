FactoryGirl.define do
  factory :review do
    association :product, factory: :product
    association :user, factory: :user

    body    { Faker::Hipster.paragraph }
    stars   { 1 + rand(5) }
  end
end
