# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_02_200953) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "state_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "neighbours", force: :cascade do |t|
    t.bigint "city_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "population_quantity"
    t.decimal "criminality_index"
    t.index ["city_id"], name: "index_neighbours_on_city_id"
  end

  create_table "occurrences", force: :cascade do |t|
    t.integer "kind", null: false
    t.datetime "reported_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "street_id", null: false
    t.index ["street_id"], name: "index_occurrences_on_street_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "streets", force: :cascade do |t|
    t.string "name", null: false
    t.string "cep", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "neighbour_id", null: false
    t.index ["neighbour_id"], name: "index_streets_on_neighbour_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "neighbours_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["neighbours_id"], name: "index_users_on_neighbours_id"
  end

  add_foreign_key "cities", "states"
  add_foreign_key "neighbours", "cities"
  add_foreign_key "occurrences", "streets"
  add_foreign_key "streets", "neighbours"
  add_foreign_key "users", "neighbours", column: "neighbours_id"
end
