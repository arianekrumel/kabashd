# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160419103755) do

  create_table "actions", force: true do |t|
    t.text     "command"
    t.text     "response"
    t.text     "repeatResponse"
    t.text     "earlyResponse"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "result_state_id"
    t.integer  "start_state_id"
    t.integer  "progress_reward", default: 0
    t.integer  "score_reward",    default: 0
    t.string   "image"
  end

  add_index "actions", ["result_state_id"], name: "index_actions_on_result_state_id"
  add_index "actions", ["start_state_id"], name: "index_actions_on_start_state_id"

  create_table "conversations", force: true do |t|
    t.text     "query"
    t.text     "response"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confidence"
    t.integer  "game_id"
    t.string   "image"
  end

  add_index "conversations", ["game_id"], name: "index_conversations_on_game_id"

  create_table "game_states", force: true do |t|
    t.string   "level"
    t.string   "goalActions"
    t.string   "keys"
    t.string   "saveValue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "actions_id"
  end

  add_index "game_states", ["actions_id"], name: "index_game_states_on_actions_id"

  create_table "games", force: true do |t|
    t.string   "name"
    t.integer  "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "game_state_id"
    t.string   "player_name"
    t.integer  "level_num",     default: 1
    t.integer  "progress",      default: 0
    t.integer  "score",         default: 0
  end

  add_index "games", ["game_state_id"], name: "index_games_on_game_state_id"
  add_index "games", ["user_id"], name: "index_games_on_user_id"

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "zip_code"
    t.string   "password"
    t.string   "password_confirmation"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
