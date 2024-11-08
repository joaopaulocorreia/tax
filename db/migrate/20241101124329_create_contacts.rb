# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[7.2]
  def change
    create_table :contacts do |t|
      t.string :phone, null: false, index: { unique: true }
      t.string :category, null: false

      t.references :proponent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
