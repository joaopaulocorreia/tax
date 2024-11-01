class Contact < ApplicationRecord
  validates :phone, presence: true
  validates :type, presence: true

  enum :type, [ :personal, :reference ]
end
