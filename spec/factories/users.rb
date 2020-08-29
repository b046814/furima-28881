FactoryBot.define do
  factory :user do
    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    last_name {"富じサン"}
    first_name {"新たロウ"}
    last_name_k {"フジサン"}
    first_name_k {"シンタロウ"}
    birth_date {"1999-09-19"}
  end
end