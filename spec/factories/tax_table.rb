FactoryBot.define do
  factory :tax_table do
    initial { 2089.61 }
    final { 3134.4 }
    percentage { 12 }
    tag { :group_three }
    calculated_tax { 125.34 }
  end
end
