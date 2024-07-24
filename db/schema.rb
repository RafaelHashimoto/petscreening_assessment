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

ActiveRecord::Schema[7.1].define(version: 2024_07_24_001646) do
  create_table "breed_infos", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "max_life_expectancy"
    t.integer "male_max_weight"
    t.integer "male_min_weight"
    t.integer "female_max_weight"
    t.integer "female_min_weight"
    t.boolean "hypoallergenic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_breed_infos_on_name", unique: true
  end

  create_table "owners", force: :cascade do |t|
    t.string "first_name", limit: 50
    t.string "last_name", limit: 50
    t.string "email", limit: 50
    t.string "phone_number", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.string "kind"
    t.string "breed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "weight"
    t.integer "owner_id"
    t.index ["breed"], name: "index_pets_on_breed"
    t.index ["owner_id"], name: "index_pets_on_owner_id"
  end

end
