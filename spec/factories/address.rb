FactoryBot.define do
  factory :address do
    address { Faker::Address.street_name }
    number { 123 }
    neighborhood { Faker::Address.community }
    city { Faker::Address.city }
    state { Faker::Address.state }
    postal_code { Faker::Address.postcode }

    proponent { create :proponent }
  end
end
