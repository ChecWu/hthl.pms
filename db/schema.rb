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

ActiveRecord::Schema.define(version: 2019_09_09_030242) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.integer "user_id"
    t.integer "project"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customer_contacts", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "telephone", default: "", null: false
    t.string "phone_number"
    t.string "other_phone"
    t.string "email", default: "", null: false
    t.string "address", default: "", null: false
    t.string "position", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "customer_id"
    t.index ["customer_id"], name: "index_customer_contacts_on_customer_id"
  end

  create_table "customer_contacts_projects", id: false, force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "customer_contact_id", null: false
    t.index ["project_id", "customer_contact_id"], name: "unique_relationship", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "deleted_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", default: "", null: false, comment: "????????????"
    t.text "support_details", default: "", null: false, comment: "????????????/??????"
    t.datetime "expected_at", comment: "????????????"
    t.integer "genre", default: 0, null: false, comment: "??????"
    t.integer "auditor", comment: "?????????"
    t.integer "tech_auditor", comment: "???????????????"
    t.text "remake", comment: "??????"
    t.float "time_limit", default: 0.0, null: false, comment: "??????"
    t.integer "status", default: 0, null: false, comment: "??????"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", comment: "???????????????/????????????"
    t.bigint "customer_id", comment: "???????????????"
    t.string "number"
    t.datetime "approved_at"
    t.datetime "done_at"
    t.datetime "deleted_at"
    t.index ["customer_id"], name: "index_projects_on_customer_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.text "permissions"
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "explain"
    t.string "status"
  end

  create_table "satisfactions", force: :cascade do |t|
    t.bigint "project_id", comment: "??????id"
    t.bigint "customer_id", comment: "?????????id"
    t.string "case_num", comment: "CASE???"
    t.integer "service_type", default: 0, null: false, comment: "????????????"
    t.datetime "start_at", comment: "??????????????????"
    t.datetime "use_at", comment: "??????????????????"
    t.integer "true_at", comment: "??????????????????(??????)"
    t.integer "service_quality", default: 0, null: false, comment: "????????????"
    t.integer "complaints_hotline", default: 0, null: false, comment: "????????????"
    t.integer "service_engineer", default: 0, null: false, comment: "??????????????????"
    t.integer "engineer", default: 0, null: false, comment: "?????????"
    t.string "engineer_satisfaction", comment: "?????????????????????"
    t.integer "technical_support", default: 0, null: false, comment: "????????????"
    t.integer "sales_service", default: 0, null: false, comment: "????????????"
    t.integer "customer_eturn_visit", default: 0, null: false, comment: "????????????"
    t.string "other_opinions", default: "0", null: false, comment: "????????????"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "phone_number", default: "", null: false
    t.string "name", default: "", null: false
    t.integer "sex", default: 0, null: false
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
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id"
    t.string "status"
    t.string "explain"
    t.bigint "department_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "customer_contacts", "customers"
  add_foreign_key "projects", "customers"
  add_foreign_key "projects", "users"
  add_foreign_key "users", "roles"
end
