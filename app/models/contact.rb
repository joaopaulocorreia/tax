# frozen_string_literal: true

class Contact < ApplicationRecord
  validates :phone, presence: true, uniqueness: { scope: :proponent }
  validates :category, inclusion: { in: %w[personal reference] }

  belongs_to :proponent
end
