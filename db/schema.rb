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

ActiveRecord::Schema.define(version: 20150204010441) do

  create_table "genres", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "owner_id"
  end

  create_table "submissions", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "name"
    t.integer  "user_id"
    t.integer  "likes",      default: 0
    t.integer  "group_id"
    t.integer  "track_id"
    t.integer  "play_count", default: 0
  end

  create_table "tag_relationships", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "tagged_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tag_relationships", ["tag_id", "tagged_id"], name: "index_tag_relationships_on_tag_id_and_tagged_id", unique: true
  add_index "tag_relationships", ["tag_id"], name: "index_tag_relationships_on_tag_id"
  add_index "tag_relationships", ["tagged_id"], name: "index_tag_relationships_on_tagged_id"

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tracks", force: :cascade do |t|
    t.string   "external_link"
    t.string   "artist"
    t.float    "track_length"
    t.string   "track_name"
    t.string   "artwork_url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "username"
    t.string   "password_digest"
    t.float    "reputation",      default: 0.0
    t.boolean  "is_admin",        default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "remember_digest"
    t.string   "image"
  end

  create_table "votes", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "user_id"
  end

end
