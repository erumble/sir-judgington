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

ActiveRecord::Schema.define(version: 20150924052028) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.boolean  "common",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_contests", id: false, force: true do |t|
    t.integer "category_id", null: false
    t.integer "contest_id",  null: false
  end

  add_index "categories_contests", ["contest_id", "category_id"], name: "index_categories_contests_on_contest_id_and_category_id", unique: true, using: :btree

  create_table "category_entries", force: true do |t|
    t.integer  "category_id"
    t.integer  "entry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "category_entries", ["category_id"], name: "index_category_entries_on_category_id", using: :btree
  add_index "category_entries", ["entry_id", "category_id"], name: "index_category_entries_on_entry_id_and_category_id", unique: true, using: :btree
  add_index "category_entries", ["entry_id"], name: "index_category_entries_on_entry_id", using: :btree

  create_table "characters", force: true do |t|
    t.string   "name"
    t.string   "property"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contests", force: true do |t|
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contests_judging_times", id: false, force: true do |t|
    t.integer "contest_id",      null: false
    t.integer "judging_time_id", null: false
  end

  add_index "contests_judging_times", ["judging_time_id", "contest_id"], name: "index_contests_judging_times_on_judging_time_id_and_contest_id", unique: true, using: :btree

  create_table "cosplays", force: true do |t|
    t.integer  "person_id"
    t.integer  "character_id"
    t.integer  "entry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cosplays", ["character_id"], name: "index_cosplays_on_character_id", using: :btree
  add_index "cosplays", ["entry_id"], name: "index_cosplays_on_entry_id", using: :btree
  add_index "cosplays", ["person_id"], name: "index_cosplays_on_person_id", using: :btree

  create_table "entries", force: true do |t|
    t.integer  "skill_level",     default: 0
    t.boolean  "hot_or_bulky",    default: false
    t.string   "group_name"
    t.integer  "contest_id"
    t.integer  "handler_count",   default: 0
    t.integer  "judging_time_id"
    t.string   "entry_num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["contest_id"], name: "index_entries_on_contest_id", using: :btree
  add_index "entries", ["judging_time_id"], name: "index_entries_on_judging_time_id", using: :btree

  create_table "judging_times", force: true do |t|
    t.string   "time"
    t.boolean  "common",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "number_chalices", force: true do |t|
    t.integer  "exhibition",   default: 0
    t.integer  "hot_or_bulky", default: 0
    t.integer  "regular",      default: 0
    t.integer  "lock_version"
    t.integer  "contest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "number_chalices", ["contest_id"], name: "index_number_chalices_on_contest_id", using: :btree

  create_table "people", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nickname"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["email"], name: "index_people_on_email", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
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
    t.boolean  "approved",               default: false, null: false
  end

  add_index "users", ["approved"], name: "index_users_on_approved", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
