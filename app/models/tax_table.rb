class TaxTable < ApplicationRecord
  validates :initial, presence: true
  validates :final, presence: true
  validates :calculated_tax, presence: true
  validates :percentage, presence: true
  validates :tag, presence: true
end
