class Proponent < ApplicationRecord
  validates :name, presence: true
  validates :cpf, presence: true
  validates :birthday, presence: true
  validates :salary, presence: true
  validates_presence_of :tax, message: 'Fill salary and click in the button Calculate tax'

  has_one :address, dependent: :destroy
  has_many :contacts, dependent: :destroy
end
