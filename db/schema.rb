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

ActiveRecord::Schema.define(version: 20140712015555) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.boolean  "active",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_entries", id: false, force: true do |t|
    t.integer "category_id", null: false
    t.integer "entry_id",    null: false
  end

  add_index "categories_entries", ["entry_id", "category_id"], name: "index_categories_entries_on_entry_id_and_category_id", unique: true, using: :btree

  create_table "contestants", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contestants_costumes", id: false, force: true do |t|
    t.integer "contestant_id", null: false
    t.integer "costume_id",    null: false
  end

  add_index "contestants_costumes", ["costume_id", "contestant_id"], name: "index_contestants_costumes_on_costume_id_and_contestant_id", unique: true, using: :btree

  create_table "contestants_entries", id: false, force: true do |t|
    t.integer "contestant_id", null: false
    t.integer "entry_id",      null: false
  end

  add_index "contestants_entries", ["entry_id", "contestant_id"], name: "index_contestants_entries_on_entry_id_and_contestant_id", unique: true, using: :btree

  create_table "contests", force: true do |t|
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "costumes", force: true do |t|
    t.string   "character_name"
    t.string   "property"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "costumes", ["owner_id"], name: "index_costumes_on_owner_id", using: :btree

  create_table "entries", force: true do |t|
    t.integer  "skill_level",   default: 0
    t.boolean  "hot_or_bulky",  default: false
    t.string   "group_name"
    t.integer  "contest_id"
    t.integer  "handler_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["contest_id"], name: "index_entries_on_contest_id", using: :btree

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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "role"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
