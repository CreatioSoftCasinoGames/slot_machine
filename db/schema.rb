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

ActiveRecord::Schema.define(version: 20140910185447) do

  create_table "assets", force: true do |t|
    t.string   "version"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
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

  create_table "games", force: true do |t|
    t.string   "name"
    t.text     "description"
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

  create_table "machines", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "theme_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "pay_lines", force: true do |t|
    t.string   "label"
    t.integer  "x"
    t.integer  "y"
    t.integer  "math_model_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pay_tables", force: true do |t|
    t.decimal  "count",         precision: 10, scale: 0
    t.integer  "stamp_id"
    t.integer  "math_model_id"
    t.decimal  "points",        precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reels", force: true do |t|
    t.integer  "stamp_id"
    t.integer  "size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "math_model_id"
    t.string   "label"
  end

  create_table "stamps", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "math_model_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "symbol_type"
    t.integer  "size",          default: 1
  end

  create_table "themes", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
