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

ActiveRecord::Schema[7.0].define(version: 2022_09_18_114143) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievement_categories", force: :cascade do |t|
    t.integer "gw_id"
    t.string "name_en"
    t.string "name_fr"
    t.string "description_en"
    t.string "description_fr"
    t.integer "order"
    t.string "icon"
    t.string "achievements_array", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "achievements", force: :cascade do |t|
    t.integer "gw_id"
    t.string "icon"
    t.string "name_en"
    t.string "description_en"
    t.string "requirement_en"
    t.string "locked_text_en"
    t.string "gw_type"
    t.string "flags", array: true
    t.json "tiers"
    t.string "prerequisites", array: true
    t.json "rewards"
    t.json "bits"
    t.integer "point_cap"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_fr"
    t.string "description_fr"
    t.string "requirement_fr"
    t.string "locked_text_fr"
    t.bigint "achievement_category_id"
    t.index ["achievement_category_id"], name: "index_achievements_on_achievement_category_id"
  end

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

  create_table "player_achievements", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "achievement_id", null: false
    t.integer "gw_id"
    t.string "bits"
    t.integer "current"
    t.integer "max"
    t.boolean "done"
    t.integer "repeated"
    t.boolean "unlocked"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["achievement_id"], name: "index_player_achievements_on_achievement_id"
    t.index ["player_id"], name: "index_player_achievements_on_player_id"
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
    t.bigint "user_id"
    t.index ["igname"], name: "index_players_on_igname", unique: true
    t.index ["slug"], name: "index_players_on_slug", unique: true
    t.index ["user_id"], name: "index_players_on_user_id"
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
    t.string "name_en"
    t.integer "achievement_gw_id"
    t.json "json_en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_fr"
    t.json "json_fr"
    t.bigint "achievement_id"
    t.index ["achievement_id"], name: "index_titles_on_achievement_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "discord_name"
    t.string "image_url"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "achievements", "achievement_categories"
  add_foreign_key "ladders", "seasons"
  add_foreign_key "player_achievements", "achievements"
  add_foreign_key "player_achievements", "players"
  add_foreign_key "players", "users"
  add_foreign_key "titles", "achievements"
end
