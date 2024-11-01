class CreateProponents < ActiveRecord::Migration[7.2]
  def change
    create_table :proponents do |t|
      t.string :name, null: false
      t.string :cpf, null: false
      t.date :birthday, null: false
      t.float :salary

      t.timestamps
    end
  end
end
