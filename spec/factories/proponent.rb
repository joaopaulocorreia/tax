FactoryBot.define do
  factory :proponent do
    name { Faker::Coffee.blend_name }
    cpf { Faker::Number.number(digits: 11) }
    birthday { Faker::Date.between(from: '1980-01-01', to: '2006-01-01') }
    salary { Faker::Number.decimal(l_digits: 5, r_digits: 3) }
    tax { Faker::Number.decimal(l_digits: 2, r_digits: 2) }

    tax_table { create :tax_table }
  end
end
