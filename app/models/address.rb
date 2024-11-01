class Address < ApplicationRecord
  validates :address, presence: true
  validates :number, presence: true
  validates :neighborhood, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true

  belongs_to :proponent
end
