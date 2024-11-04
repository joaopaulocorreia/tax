# frozen_string_literal: true

class Contact < ApplicationRecord
  validates :phone, presence: true
  validates :category, inclusion: { in: %w[personal reference] }
end
