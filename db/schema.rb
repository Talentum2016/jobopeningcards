# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160224105904) do

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_openings", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "image_job_file_name"
    t.string   "image_job_content_type"
    t.integer  "image_job_file_size"
    t.datetime "image_job_updated_at"
    t.string   "requirement"
    t.integer  "salary_min"
    t.integer  "salary_max"
    t.string   "contract"
    t.string   "province"
    t.integer  "user_id"
    t.integer  "profession_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "job_openings", ["profession_id"], name: "index_job_openings_on_profession_id"
  add_index "job_openings", ["user_id"], name: "index_job_openings_on_user_id"

  create_table "professions", force: :cascade do |t|
    t.string   "title"
    t.string   "image_prof_file_name"
    t.string   "image_prof_content_type"
    t.integer  "image_prof_file_size"
    t.datetime "image_prof_updated_at"
    t.integer  "category_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "professions", ["category_id"], name: "index_professions_on_category_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
