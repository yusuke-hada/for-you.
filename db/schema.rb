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

ActiveRecord::Schema[7.0].define(version: 2024_02_13_072019) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "anniversaries", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", limit: 252, null: false
    t.date "date", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_anniversaries_on_user_id"
  end

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "gift_suggestions", force: :cascade do |t|
    t.integer "age", null: false
    t.integer "gender", null: false
    t.string "business", limit: 20, null: false
    t.string "interest", limit: 20, null: false
    t.string "purpose", limit: 20, null: false
    t.string "relationship", limit: 20, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "result"
    t.string "hobbies", default: [], array: true
    t.index ["user_id"], name: "index_gift_suggestions_on_user_id"
  end

  create_table "memos", force: :cascade do |t|
    t.string "name", limit: 252, null: false
    t.string "goods", limit: 252, null: false
    t.date "time"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_memos_on_user_id"
  end

  create_table "message_cards", force: :cascade do |t|
    t.string "recipient_name", limit: 252, null: false
    t.text "message", null: false
    t.string "background_image", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_message_cards_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.integer "role", default: 0, null: false
    t.integer "age", null: false
    t.integer "gender", null: false
    t.string "business"
    t.string "hobby", default: [], array: true
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.string "line_uid"
    t.string "line_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["line_uid"], name: "index_users_on_line_uid", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  create_table "wish_lists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "item_name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wish_lists_on_user_id"
  end

  add_foreign_key "anniversaries", "users"
  add_foreign_key "gift_suggestions", "users"
  add_foreign_key "memos", "users"
  add_foreign_key "message_cards", "users"
  add_foreign_key "wish_lists", "users"
end
