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

ActiveRecord::Schema.define(version: 2021_08_15_213116) do

  create_table "active_admin_comments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "bookmarks", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "field_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["field_id"], name: "index_bookmarks_on_field_id"
    t.index ["user_id", "field_id"], name: "index_bookmarks_on_user_id_and_field_id", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "contacts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
  end

  create_table "fields", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "reservation"
    t.string "phone_number"
    t.string "business_hours"
    t.string "holiday"
    t.boolean "all_season", default: false
    t.string "season"
    t.boolean "early_in", default: false
    t.string "early_in_description"
    t.boolean "late_out", default: false
    t.string "late_out_description"
    t.string "check_in"
    t.string "check_out"
    t.boolean "day_camp", default: false
    t.string "day_camp_description"
    t.boolean "sea", default: false
    t.boolean "lake", default: false
    t.boolean "river", default: false
    t.boolean "mountain", default: false
    t.boolean "woods", default: false
    t.string "near_station"
    t.integer "near_station_km"
    t.string "near_ic"
    t.string "near_spa"
    t.string "near_supermarket"
    t.integer "elevation"
    t.boolean "section_site", default: false
    t.string "section_site_price"
    t.string "section_site_size"
    t.boolean "free_site", default: false
    t.string "free_site_price"
    t.string "free_site_size"
    t.boolean "cancel", default: false
    t.boolean "ground_turf", default: false
    t.boolean "ground_soil", default: false
    t.boolean "ground_wood_deck", default: false
    t.boolean "ground_sand", default: false
    t.boolean "bonfire", default: false
    t.boolean "direct_fire", default: false
    t.boolean "car", default: false
    t.boolean "gate", default: false
    t.boolean "manager_resident", default: false
    t.boolean "manager_on_time", default: false
    t.boolean "trash", default: false
    t.boolean "coin_shower", default: false
    t.boolean "free_shower", default: false
    t.boolean "washlet", default: false
    t.boolean "flush_toilet", default: false
    t.boolean "simple_toilet", default: false
    t.boolean "pets", default: false
    t.decimal "latitude", precision: 12, scale: 9
    t.decimal "longitude", precision: 12, scale: 9
    t.string "image"
    t.string "place_id"
    t.string "field_url"
    t.boolean "laid_back_camp", default: false
    t.boolean "two_people_solo_camp", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reviews", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.float "rate"
    t.bigint "user_id"
    t.bigint "field_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["field_id"], name: "index_reviews_on_field_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", limit: 50, default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", limit: 50, default: "", null: false
    t.string "string", limit: 50, default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookmarks", "fields"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "reviews", "fields"
  add_foreign_key "reviews", "users"
end
