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

ActiveRecord::Schema.define(version: 20171031065911) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.integer "status", default: 1, null: false
    t.string "category_constant"
    t.integer "category_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_constant"], name: "index_categories_on_category_constant"
    t.index ["name"], name: "index_categories_on_name"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "sub_category_id", null: false
    t.bigint "user_id", null: false
    t.string "name"
    t.string "description"
    t.string "band_colour"
    t.string "band_material"
    t.string "brand"
    t.string "dial_colour"
    t.string "display_type"
    t.decimal "price", default: "0.0", null: false
    t.decimal "discount_price", default: "0.0", null: false
    t.integer "status", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_products_on_name"
    t.index ["price"], name: "index_products_on_price"
    t.index ["sub_category_id"], name: "index_products_on_sub_category_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "sub_categories", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.string "name"
    t.integer "status", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_sub_categories_on_category_id"
    t.index ["name"], name: "index_sub_categories_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "username", null: false
    t.string "password_digest", null: false
    t.string "email", null: false
    t.integer "status", default: 1, null: false
    t.integer "role", default: 1, null: false
    t.date "date_of_birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "products", "sub_categories", on_delete: :cascade
  add_foreign_key "products", "users", on_delete: :cascade
  add_foreign_key "sub_categories", "categories", on_delete: :cascade
end
