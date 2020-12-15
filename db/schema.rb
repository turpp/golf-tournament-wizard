# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_15_050024) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "holes", force: :cascade do |t|
    t.integer "score"
    t.string "tee_box"
    t.integer "distance"
    t.bigint "round_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["round_id"], name: "index_holes_on_round_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "handicap"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rounds", force: :cascade do |t|
    t.bigint "tournament_id", null: false
    t.bigint "player_id", null: false
    t.integer "final_score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_rounds_on_player_id"
    t.index ["tournament_id"], name: "index_rounds_on_tournament_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.integer "entry_fee"
    t.string "rules"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "phone_number"
    t.string "password_digest"
    t.string "username"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "holes", "rounds"
  add_foreign_key "rounds", "players"
  add_foreign_key "rounds", "tournaments"
end
