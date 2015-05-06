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

ActiveRecord::Schema.define(version: 20150506105545) do

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

  create_table "distributable_jackpots", force: true do |t|
    t.integer  "jackpot_id"
    t.decimal  "seed_amount",       precision: 10, scale: 0
    t.decimal  "player_percentage", precision: 10, scale: 0
    t.decimal  "amount",            precision: 10, scale: 0
    t.boolean  "active",                                     default: true
    t.integer  "winner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_distributed",                             default: false
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
    t.decimal  "player_percent", precision: 10, scale: 0
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
    t.string   "email",                                                   default: "",    null: false
    t.string   "encrypted_password",                                      default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                           default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "country"
    t.decimal  "stars",                          precision: 10, scale: 0
    t.decimal  "diamonds",                       precision: 10, scale: 0
    t.string   "fb_id"
    t.string   "role"
    t.decimal  "total_bet",                      precision: 10, scale: 0, default: 0
    t.decimal  "coins_won",                      precision: 10, scale: 0, default: 0
    t.decimal  "coins_lost",                     precision: 10, scale: 0, default: 0
    t.integer  "current_level",                                           default: 0
    t.integer  "machine_unlocked",                                        default: 0
    t.integer  "percentage_win",                                          default: 0
    t.integer  "num_of_tournament_participated",                          default: 0
    t.decimal  "biggest_tournament_win_amount",  precision: 10, scale: 0, default: 0
    t.integer  "best_position_in_tournament",                             default: 0
    t.integer  "total_spin",                                              default: 0
    t.string   "device_id"
    t.string   "biggest_win"
    t.integer  "jackpot_win_percent",                                     default: 0
    t.decimal  "total_coins",                    precision: 10, scale: 0, default: 0
    t.string   "gifts"
    t.integer  "iap",                                                     default: 0
    t.integer  "bonus_coins",                                             default: 0
    t.boolean  "is_guest",                                                default: false
    t.string   "login_token"
    t.boolean  "online",                                                  default: false
    t.integer  "parent_id"
    t.boolean  "is_fb_connected",                                         default: false
    t.boolean  "mini_jackpot_status",                                     default: false
    t.boolean  "major_jackpot_status",                                    default: false
    t.decimal  "client_total_spin",              precision: 10, scale: 0
    t.decimal  "client_coins_won",               precision: 10, scale: 0
    t.decimal  "client_coins_lost",              precision: 10, scale: 0
    t.decimal  "client_total_bets",              precision: 10, scale: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
