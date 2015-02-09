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

ActiveRecord::Schema.define(version: 20150206051300) do

  create_table "categories", force: true do |t|
    t.string   "cat_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nouns", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  add_index "nouns", ["category_id"], name: "index_nouns_on_category_id", using: :btree

  create_table "user_infos", force: true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "uname"
    t.string   "pass"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wins"
    t.integer  "lose"
  end

end