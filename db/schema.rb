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

ActiveRecord::Schema.define(version: 2018_12_31_144552) do

  create_table "game_words", force: :cascade do |t|
    t.integer "game_id", default: 0, null: false
    t.string "word", default: "", null: false
    t.integer "position", default: 0, null: false
    t.string "who", default: "nil", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id", "position"], name: "index_game_words_on_game_id_and_position"
  end

  create_table "games", force: :cascade do |t|
    t.string "sessionid", default: "", null: false
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_games_on_name", unique: true
    t.index ["sessionid"], name: "index_games_on_sessionid"
  end

end
