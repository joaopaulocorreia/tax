# frozen_string_literal: true

class Proponent < ApplicationRecord
  validates :name, presence: true
  validates :cpf, presence: true, length: { is: 11 }
  validates :birthday, presence: true
  validates :salary, presence: true, numericality: { greater_than: 0 }

  validates :tax, presence: { message: 'fill salary to calculate tax' }, numericality: true

  belongs_to :tax_table

  has_one :address, dependent: :destroy
  has_many :contacts, dependent: :destroy
end
