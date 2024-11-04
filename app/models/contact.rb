# frozen_string_literal: true

class Contact < ApplicationRecord
  validates :phone, presence: true, uniqueness: true
  validates :category, inclusion: { in: %w[personal reference] }

  belongs_to :proponent
end
