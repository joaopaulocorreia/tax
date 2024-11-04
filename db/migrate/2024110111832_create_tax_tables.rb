class CreateTaxTables < ActiveRecord::Migration[7.2]
  def change
    create_table :tax_tables do |t|
      t.float :initial, null: false
      t.float :final, null: false
      t.float :calculated_tax, null: false
      t.float :percentage, null: false
      t.string :tag, null: false

      t.timestamps
    end
  end
end
