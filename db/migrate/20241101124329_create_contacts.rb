class CreateContacts < ActiveRecord::Migration[7.2]
  def change
    create_table :contacts do |t|
      t.string :phone, null: false
      t.string :type, null: false

      t.references :proponent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
