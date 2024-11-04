# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

t_one   = TaxTable.create! initial: 0,       final: 1045,    percentage: 7.5, tag: :group_one, calculated_tax: 78.37
t_two   = TaxTable.create! initial: 1045.01, final: 2089.6,  percentage: 9, tag: :group_two, calculated_tax: 94.01
t_three = TaxTable.create! initial: 2089.61, final: 3134.4,  percentage:  12, tag: :group_three, calculated_tax: 125.34
t_four  = TaxTable.create! initial: 3134.41, final: 6101.06, percentage:  14, tag: :group_four,  calculated_tax: 415.33

10.times do |_i|
  FactoryBot.create :proponent, tax_table: t_one
end

8.times do |_i|
  FactoryBot.create :proponent, tax_table: t_two
end

5.times do |_i|
  FactoryBot.create :proponent, tax_table: t_three
end

3.times do |_i|
  FactoryBot.create :proponent, tax_table: t_four
end
