class Contact < ApplicationRecord
  validates :phone, presence: true
  validates :category, inclusion: { in: [ 'personal', 'reference' ] }
end
