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

ActiveRecord::Schema[7.0].define(version: 2023_03_26_023258) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "code", limit: 22, null: false
    t.string "title", null: false
    t.text "description"
    t.bigint "category_id", null: false
    t.bigint "status_id", null: false
    t.boolean "public", default: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["category_id"], name: "index_activities_on_category_id"
    t.index ["code"], name: "index_activities_on_code", unique: true
    t.index ["description"], name: "index_activities_on_description"
    t.index ["discarded_at"], name: "index_activities_on_discarded_at"
    t.index ["status_id"], name: "index_activities_on_status_id"
    t.index ["title"], name: "index_activities_on_title"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "failed_login_attempts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_failed_login_attempts_on_user_id"
  end

  create_table "profile_visitors", force: :cascade do |t|
    t.bigint "visitee_id", null: false
    t.bigint "visitator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["visitator_id"], name: "index_profile_visitors_on_visitator_id"
    t.index ["visitee_id"], name: "index_profile_visitors_on_visitee_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_statuses_on_name", unique: true
  end

  create_table "user_validation_tokens", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "validation_token_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "validation_token_id"], name: "index_user_validation_tokens_on_user_id_and_validation_token_id", unique: true
    t.index ["user_id"], name: "index_user_validation_tokens_on_user_id"
    t.index ["validation_token_id"], name: "index_user_validation_tokens_on_validation_token_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "phone", null: false
    t.string "cpf", null: false
    t.integer "gender", default: 0, null: false
    t.datetime "blocked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "uuid", null: false
    t.boolean "show_phone", default: false, null: false
    t.string "avatar"
  end

  create_table "validation_token_deny_lists", force: :cascade do |t|
    t.bigint "validation_token_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["validation_token_id"], name: "index_validation_token_deny_lists_on_validation_token_id"
  end

  create_table "validation_tokens", force: :cascade do |t|
    t.string "token"
    t.datetime "expires_at", precision: nil, null: false
    t.datetime "sent_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "activities", "categories"
  add_foreign_key "activities", "statuses"
  add_foreign_key "activities", "users"
  add_foreign_key "failed_login_attempts", "users"
  add_foreign_key "profile_visitors", "users", column: "visitator_id"
  add_foreign_key "profile_visitors", "users", column: "visitee_id"
  add_foreign_key "user_validation_tokens", "users"
  add_foreign_key "user_validation_tokens", "validation_tokens"
  add_foreign_key "validation_token_deny_lists", "validation_tokens"
end
