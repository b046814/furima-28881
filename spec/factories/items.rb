FactoryBot.define do
  factory :item do
    name { Faker::Team.name }
    description { Faker::Lorem.sentence }
    category_id { 5 }
    condition_id { 2 }
    ship_expense_id { 2 }
    prefecture_id { 31 }
    period_id { 3 }
    price { 1000 }

    association :user
  end
end
