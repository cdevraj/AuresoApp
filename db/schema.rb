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

ActiveRecord::Schema.define(version: 20170918160642) do

  create_table "cars", force: :cascade do |t|
    t.string   "slug"
    t.integer  "max_speed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cars", ["slug"], name: "index_cars_on_slug"

  create_table "tracks", force: :cascade do |t|
    t.string   "name"
    t.string   "surface_type"
    t.integer  "slow_factor"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "tracks", ["name"], name: "index_tracks_on_name"

end
