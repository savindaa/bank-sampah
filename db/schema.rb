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

ActiveRecord::Schema.define(version: 20180414131728) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "acct_transactions", force: :cascade do |t|
    t.string "tr_id"
    t.string "transaction_type_id"
    t.integer "customer_id"
    t.string "customer_phone_number"
    t.integer "branch_id"
    t.string "branch_name"
    t.integer "amount", default: 0
    t.integer "point_received", default: 0
    t.integer "adjusted_bal"
    t.boolean "approved", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "showed", default: true
    t.index ["approved"], name: "index_acct_transactions_on_approved"
    t.index ["branch_id"], name: "index_acct_transactions_on_branch_id"
    t.index ["branch_name"], name: "index_acct_transactions_on_branch_name"
    t.index ["customer_id"], name: "index_acct_transactions_on_customer_id"
    t.index ["customer_phone_number"], name: "index_acct_transactions_on_customer_phone_number"
    t.index ["showed"], name: "index_acct_transactions_on_showed"
    t.index ["tr_id"], name: "index_acct_transactions_on_tr_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.string "body"
    t.string "author"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author"], name: "index_articles_on_author"
    t.index ["title"], name: "index_articles_on_title"
  end

  create_table "branches", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "password_digest"
    t.string "provinsi"
    t.string "kabupaten"
    t.string "kecamatan"
    t.string "kelurahan"
    t.string "address"
    t.integer "balance", default: 0
    t.string "profile_picture"
    t.boolean "blocked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_branches_on_name"
    t.index ["phone_number"], name: "index_branches_on_phone_number"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "password_digest"
    t.string "provinsi"
    t.string "kabupaten"
    t.string "kecamatan"
    t.string "kelurahan"
    t.string "address"
    t.integer "point", default: 0
    t.integer "balance", default: 0
    t.string "profile_picture"
    t.boolean "blocked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone_number"], name: "index_customers_on_phone_number"
  end

  create_table "districts", id: false, force: :cascade do |t|
    t.integer "code", null: false
    t.integer "regency_code", null: false
    t.string "name", null: false
    t.index ["regency_code"], name: "index_districts_on_regency_code"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price", null: false
    t.index ["name"], name: "index_items_on_name"
  end

  create_table "my_vouchers", force: :cascade do |t|
    t.integer "voucher_id"
    t.integer "customer_id"
    t.boolean "used", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pick_requests", force: :cascade do |t|
    t.string "pr_id"
    t.integer "customer_id"
    t.string "customer_address"
    t.integer "branch_id"
    t.integer "amount", default: 0
    t.integer "point_received", default: 0
    t.string "status", default: "1"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_pick_requests_on_branch_id"
    t.index ["customer_id"], name: "index_pick_requests_on_customer_id"
    t.index ["pr_id"], name: "index_pick_requests_on_pr_id"
    t.index ["status"], name: "index_pick_requests_on_status"
  end

  create_table "provinces", id: false, force: :cascade do |t|
    t.integer "code", null: false
    t.string "name", null: false
  end

  create_table "regencies", id: false, force: :cascade do |t|
    t.integer "code", null: false
    t.integer "province_code", null: false
    t.string "name", null: false
    t.index ["province_code"], name: "index_regencies_on_province_code"
  end

  create_table "trash_details", force: :cascade do |t|
    t.string "item_name"
    t.decimal "weight"
    t.integer "need_detail_id"
    t.string "need_detail_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_price"
    t.index ["need_detail_id", "need_detail_type"], name: "index_trash_details_on_need_detail_id_and_need_detail_type"
  end

  create_table "trash_weights", force: :cascade do |t|
    t.decimal "plastik"
    t.decimal "kertas"
    t.decimal "botol"
    t.decimal "besi"
    t.decimal "other"
    t.integer "need_detail_id"
    t.string "need_detail_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["need_detail_id", "need_detail_type"], name: "index_trash_weights_on_need_detail_id_and_need_detail_type"
  end

  create_table "user_roles", force: :cascade do |t|
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "villages", id: false, force: :cascade do |t|
    t.bigint "code", null: false
    t.integer "district_code", null: false
    t.string "name", null: false
    t.index ["district_code"], name: "index_villages_on_district_code"
  end

  create_table "vouchers", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.integer "point_needed"
    t.string "description"
    t.string "picture"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_vouchers_on_active"
    t.index ["category"], name: "index_vouchers_on_category"
  end

end
