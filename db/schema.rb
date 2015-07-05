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

ActiveRecord::Schema.define(version: 20150705143734) do

  create_table "operators", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "operators", ["email"], name: "index_operators_on_email", unique: true

  create_table "user_tokens", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_tokens", ["user_id"], name: "index_user_tokens_on_user_id"

  create_table "user_transitions", force: :cascade do |t|
    t.string   "to_state",                   null: false
    t.text     "metadata",    default: "{}"
    t.integer  "sort_key",                   null: false
    t.integer  "user_id",                    null: false
    t.boolean  "most_recent",                null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "user_transitions", ["user_id", "most_recent"], name: "index_user_transitions_parent_most_recent", unique: true, where: "most_recent"
  add_index "user_transitions", ["user_id", "sort_key"], name: "index_user_transitions_parent_sort", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "status"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
