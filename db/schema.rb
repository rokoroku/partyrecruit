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

ActiveRecord::Schema.define(version: 20140602093953) do

  create_table "has_tag", force: true do |t|
    t.integer "party_id"
    t.integer "tag_id"
  end

  add_index "has_tag", ["party_id", "tag_id"], name: "index_has_tag_on_party_id_and_tag_id", unique: true, using: :btree
  add_index "has_tag", ["party_id"], name: "index_has_tag_on_party_id", using: :btree
  add_index "has_tag", ["tag_id"], name: "index_has_tag_on_tag_id", using: :btree

  create_table "microposts", force: true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "party_id"
    t.integer  "type"
  end

  add_index "microposts", ["party_id"], name: "idx_microposts_party_id", using: :btree
  add_index "microposts", ["user_id"], name: "idx_microposts_user_id", using: :btree

  create_table "participate_in", force: true do |t|
    t.integer "user_id"
    t.integer "party_id"
    t.boolean "leader"
    t.string  "status_msg"
  end

  add_index "participate_in", ["party_id"], name: "index_participate_in_on_party_id", using: :btree
  add_index "participate_in", ["user_id", "party_id"], name: "index_participate_in_on_user_id_and_party_id", unique: true, using: :btree
  add_index "participate_in", ["user_id"], name: "index_participate_in_on_user_id", using: :btree

  create_table "parties", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "user_limit"
    t.float    "location_longitude"
    t.float    "location_latitude"
    t.boolean  "recruiting"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.date     "last_login"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
