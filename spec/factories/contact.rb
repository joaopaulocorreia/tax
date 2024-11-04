FactoryBot.define do
  factory :contact do
    phone { Faker::PhoneNumber.cell_phone_in_e164 }
    category { :personal }

    proponent { create :proponent }
  end
end
