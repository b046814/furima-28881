FactoryBot.define do
  factory :order_address do
    token { Faker::Internet.password }
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city_name { '広島市安佐南区長束' }
    block_number { '5-6-8' }
    building { 'シャルマンドミール505号室' }
    phone_number { '34567890000' }
  end
end
