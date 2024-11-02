class Proponent < ApplicationRecord
  validates :name, presence: true
  validates :cpf, presence: true
  validates :birthday, presence: true

  has_one :address, dependent: :destroy
  has_many :contacts, dependent: :destroy
end
