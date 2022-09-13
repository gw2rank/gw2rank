# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_09_13_171806) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "ladders", force: :cascade do |t|
    t.bigint "season_id", null: false
    t.string "region"
    t.text "json"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_ladders_on_season_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "igname"
    t.integer "best_rating", default: 0
    t.integer "best_rating_season_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "api_key"
    t.json "titles"
    t.string "slug"
    t.integer "best_rank"
    t.index ["igname"], name: "index_players_on_igname", unique: true
    t.index ["slug"], name: "index_players_on_slug", unique: true
  end

  create_table "seasons", force: :cascade do |t|
    t.string "gw_id"
    t.string "name"
    t.datetime "start", precision: nil
    t.datetime "end", precision: nil
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "json"
    t.boolean "published", default: true
  end

  create_table "titles", force: :cascade do |t|
    t.integer "gw_id"
    t.string "name"
    t.integer "achievement_gw_id"
    t.json "json"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "ladders", "seasons"
end
