# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_11_01_124329) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "address", null: false
    t.string "number", null: false
    t.string "neighborhood", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "postal_code", null: false
    t.bigint "proponent_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proponent_id"], name: "index_addresses_on_proponent_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "phone", null: false
    t.string "category", null: false
    t.bigint "proponent_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone"], name: "index_contacts_on_phone", unique: true
    t.index ["proponent_id"], name: "index_contacts_on_proponent_id"
  end

  create_table "proponents", force: :cascade do |t|
    t.string "name", null: false
    t.string "cpf", null: false
    t.date "birthday", null: false
    t.decimal "salary", precision: 8, scale: 2, null: false
    t.decimal "tax", precision: 8, scale: 2, null: false
    t.bigint "tax_table_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tax_table_id"], name: "index_proponents_on_tax_table_id"
  end

  create_table "tax_tables", force: :cascade do |t|
    t.float "initial", null: false
    t.float "final", null: false
    t.float "calculated_tax", null: false
    t.float "percentage", null: false
    t.string "tag", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addresses", "proponents"
  add_foreign_key "contacts", "proponents"
  add_foreign_key "proponents", "tax_tables"
end
