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

ActiveRecord::Schema[7.0].define(version: 2023_03_22_001410) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.boolean "enabled", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "user_validation_tokens", "users"
  add_foreign_key "user_validation_tokens", "validation_tokens"
  add_foreign_key "validation_token_deny_lists", "validation_tokens"
end
