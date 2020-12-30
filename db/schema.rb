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

ActiveRecord::Schema.define(version: 2020_12_21_071603) do

  create_table "admins", force: :cascade do |t|
    t.string "user_name", null: false
    t.string "full_name", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_bookmarks_on_event_id"
    t.index ["member_id"], name: "index_bookmarks_on_member_id"
  end

  create_table "event_tags", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_tags_on_event_id"
    t.index ["tag_id"], name: "index_event_tags_on_tag_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "host_id", null: false
    t.string "name", null: false
    t.date "held_at", null: false
    t.integer "capacity", null: false
    t.integer "price", null: false
    t.text "detail", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["host_id"], name: "index_events_on_host_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "user_name", null: false
    t.string "full_name", null: false
    t.integer "gender", default: 1, null: false
    t.string "email", null: false
    t.date "birthday", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "place_bookings", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "place_id", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_place_bookings_on_event_id"
    t.index ["place_id"], name: "index_place_bookings_on_place_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.integer "capacity", null: false
    t.integer "rank", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reputations", force: :cascade do |t|
    t.integer "liked_member_id", null: false
    t.integer "like_member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["like_member_id"], name: "index_reputations_on_like_member_id"
    t.index ["liked_member_id"], name: "index_reputations_on_liked_member_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_tickets_on_event_id"
    t.index ["member_id"], name: "index_tickets_on_member_id"
  end

end
