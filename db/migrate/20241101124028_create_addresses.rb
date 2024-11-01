class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :number
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :postal_code

      t.references :proponent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
