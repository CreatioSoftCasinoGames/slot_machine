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

ActiveRecord::Schema.define(version: 20150727072644) do

  create_table "api_keys", force: true do |t|
    t.string   "token"
    t.boolean  "active",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assets", force: true do |t|
    t.string   "version"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size",    default: 0
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
    t.string   "label"
    t.boolean  "active"
    t.string   "bundle_type"
    t.integer  "resource_id"
    t.string   "resource_type"
  end

  create_table "celebrations", force: true do |t|
    t.string   "celebrations"
    t.string   "reward"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_bugs", force: true do |t|
    t.text     "exception"
    t.string   "bug_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "test_mode",  default: false
  end

  create_table "distributable_jackpots", force: true do |t|
    t.integer  "jackpot_id"
    t.decimal  "seed_amount",                 precision: 10, scale: 0
    t.decimal  "player_percentage",           precision: 10, scale: 0
    t.integer  "amount",            limit: 8
    t.boolean  "active",                                               default: true
    t.integer  "winner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_distributed",                                       default: false
  end

  create_table "friend_requests", force: true do |t|
    t.integer  "user_id"
    t.integer  "requested_to_id"
    t.boolean  "confirmed",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_versions", force: true do |t|
    t.string   "version"
    t.string   "device_type"
    t.boolean  "require_update"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gift_requests", force: true do |t|
    t.integer  "user_id"
    t.integer  "send_to_id"
    t.boolean  "confirmed",                           default: false
    t.string   "gift_type"
    t.decimal  "gift_value", precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.integer  "resource_id"
    t.string   "resource_type"
    t.string   "label"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jackpots", force: true do |t|
    t.string   "jackpot_type"
    t.decimal  "seed_amount",    precision: 10, scale: 0
    t.float    "player_percent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "duration",       precision: 10, scale: 0
  end

  create_table "login_histories", force: true do |t|
    t.boolean  "active"
    t.integer  "user_id"
    t.string   "login_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "machines", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "game_id"
    t.integer  "machine_number"
    t.string   "machine_type"
    t.integer  "min_players"
    t.integer  "max_players"
  end

  add_index "machines", ["machine_number"], name: "index_machines_on_machine_number", unique: true, using: :btree

  create_table "math_models", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "machine_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "version"
    t.boolean  "active"
    t.integer  "free_spins_multipliers", default: 0
    t.string   "num_free_spins",         default: "0"
    t.string   "wild_type"
    t.boolean  "is_irregular",           default: false
    t.boolean  "is_special",             default: false
    t.integer  "size_x",                 default: 3
    t.integer  "size_y",                 default: 3
    t.integer  "num_pay_lines"
  end

  create_table "mini_games", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "machine_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players_prizes", force: true do |t|
    t.float    "prize_pool_percent"
    t.float    "next_winner_difference"
    t.float    "user_score_percent"
    t.float    "player_one_percent"
    t.float    "player_two_percent"
    t.float    "player_three_percent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tournament_users", force: true do |t|
    t.integer  "tournament_id"
    t.integer  "user_id"
    t.decimal  "rank",          precision: 10, scale: 0
    t.integer  "point"
    t.decimal  "prize",         precision: 10, scale: 0
    t.boolean  "status",                                 default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tournaments", force: true do |t|
    t.integer  "machine_id"
    t.integer  "min_player"
    t.integer  "max_player"
    t.integer  "min_entry_level"
    t.integer  "max_entry_level"
    t.decimal  "seed_money",      precision: 10, scale: 0
    t.decimal  "time_out",        precision: 10, scale: 0, default: 1000000
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "interval"
    t.integer  "points_required"
  end

  create_table "users", force: true do |t|
    t.string   "email",                                                             default: "",    null: false
    t.string   "encrypted_password",                                                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "country"
    t.decimal  "stars",                                    precision: 10, scale: 0
    t.string   "fb_id"
    t.string   "role"
    t.integer  "total_bet",                      limit: 8,                          default: 0
    t.integer  "coins_won",                      limit: 8,                          default: 0
    t.integer  "coins_lost",                     limit: 8,                          default: 0
    t.integer  "current_level",                                                     default: 0
    t.integer  "machine_unlocked",                                                  default: 0
    t.integer  "percentage_win",                                                    default: 0
    t.integer  "num_of_tournament_participated",                                    default: 0
    t.integer  "biggest_tournament_win_amount",  limit: 8,                          default: 0
    t.integer  "best_position_in_tournament",                                       default: 0
    t.integer  "total_spin",                                                        default: 0
    t.string   "device_id"
    t.integer  "biggest_win",                    limit: 8
    t.integer  "jackpot_win_percent",                                               default: 0
    t.integer  "total_coins",                    limit: 8,                          default: 0
    t.boolean  "is_guest",                                                          default: false
    t.string   "login_token"
    t.boolean  "online",                                                            default: false
    t.integer  "parent_id"
    t.boolean  "is_fb_connected",                                                   default: false
    t.integer  "version"
    t.integer  "total_iap_made",                 limit: 8
    t.datetime "last_logout_time"
    t.string   "device",                                                            default: ""
    t.boolean  "update_required",                                                   default: false
    t.string   "game_version",                                                      default: ""
    t.string   "bet_index",                                                         default: "0"
    t.string   "bet_per_line",                                                      default: "1"
    t.string   "unique_id",                                                         default: ""
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
