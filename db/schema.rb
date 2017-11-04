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

ActiveRecord::Schema.define(version: 20171104050150) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "recipient", null: false
    t.string "organisation"
    t.string "line_one", null: false
    t.string "line_two"
    t.string "town", null: false
    t.string "postcode", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "order_products", force: :cascade do |t|
    t.string "order_id", null: false
    t.bigint "product_id", null: false
    t.bigint "size_id", null: false
    t.integer "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_order_products_on_product_id"
    t.index ["size_id"], name: "index_order_products_on_size_id"
  end

  create_table "orders", id: false, force: :cascade do |t|
    t.string "reference", null: false
    t.bigint "user_id", null: false
    t.bigint "address_id", null: false
    t.bigint "promo_code_id"
    t.integer "state", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 0
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["promo_code_id"], name: "index_orders_on_promo_code_id"
    t.index ["reference"], name: "index_orders_on_reference"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "slug", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.decimal "price", precision: 7, scale: 2, default: "0.0", null: false
    t.boolean "hidden", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category", default: 0
    t.decimal "discount", precision: 3, scale: 2, default: "0.0"
    t.string "display_picture_file_name"
    t.string "display_picture_content_type"
    t.integer "display_picture_file_size"
    t.datetime "display_picture_updated_at"
    t.index ["slug"], name: "index_products_on_slug"
  end

  create_table "promo_codes", id: false, force: :cascade do |t|
    t.string "code", null: false
    t.string "label", null: false
    t.integer "discount", null: false
    t.date "start_date", null: false
    t.date "finish_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_promo_codes_on_code"
  end

  create_table "sizes", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "label", null: false
    t.integer "stock", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_sizes_on_product_id"
  end

  create_table "support_articles", force: :cascade do |t|
    t.string "slug", null: false
    t.string "title", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.integer "category", default: 0
    t.index ["slug"], name: "index_support_articles_on_slug"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "role", default: 0
    t.integer "order_count", default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
