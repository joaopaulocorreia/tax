class CreateProponents < ActiveRecord::Migration[7.2]
  def change
    create_table :proponents do |t|
      t.string :name, null: false
      t.string :cpf, null: false
      t.date :birthday, null: false
      t.decimal :salary, null: false, precision: 8, scale: 2
      t.decimal :tax, null: false, precision: 8, scale: 2

      t.timestamps
    end
  end
end
