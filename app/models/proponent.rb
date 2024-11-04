class Proponent < ApplicationRecord
  validates :name, presence: true
  validates :cpf, presence: true, length: { is: 11 }
  validates :birthday, presence: true
  validates :salary, presence: true, numericality: { greater_than: 0 }

  validates_presence_of :tax, message: 'fill salary to calculate tax'

  has_one :address, dependent: :destroy
  has_many :contacts, dependent: :destroy
end
