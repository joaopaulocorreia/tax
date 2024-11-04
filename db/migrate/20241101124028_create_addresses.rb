# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.string :address, null: false
      t.string :number, null: false
      t.string :neighborhood, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :postal_code, null: false

      t.references :proponent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
