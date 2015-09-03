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

ActiveRecord::Schema.define(version: 20150902130439) do

  create_table "expertises", force: :cascade do |t|
    t.string   "expertise_in",                limit: 255
    t.string   "professional_expertise_info", limit: 255
    t.string   "reference_name",              limit: 150
    t.string   "reference_number",            limit: 15
    t.string   "reference_email",             limit: 100
    t.string   "expertise_verified_status",   limit: 255,   default: "UnVerified"
    t.integer  "trainer_id",                  limit: 4
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.text     "comments",                    limit: 65535
  end

  add_index "expertises", ["trainer_id"], name: "index_expertises_on_trainer_id", using: :btree

  create_table "qualifications", force: :cascade do |t|
    t.string   "course_name",        limit: 150
    t.string   "course_type",        limit: 200
    t.text     "course_description", limit: 65535
    t.date     "start_date"
    t.date     "end_date"
    t.string   "duration",           limit: 100
    t.string   "percentage",         limit: 100
    t.string   "grade",              limit: 100
    t.integer  "trainer_id",         limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "completed_from",     limit: 255
  end

  add_index "qualifications", ["trainer_id"], name: "index_qualifications_on_trainer_id", using: :btree

  create_table "recruiters", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "",             null: false
    t.string   "encrypted_password",     limit: 255,   default: "",             null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,              null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.string   "firm_name",              limit: 200
    t.string   "firm_type",              limit: 200,   default: "not selected"
    t.string   "firm_number",            limit: 15
    t.text     "firm_address",           limit: 65535
    t.string   "city",                   limit: 255
    t.string   "state",                  limit: 255
    t.string   "country",                limit: 255
    t.string   "pincode",                limit: 6
    t.string   "contact_person_name",    limit: 150
    t.string   "contact_person_email",   limit: 255
    t.string   "contact_person_number",  limit: 15
    t.string   "subscribed_plan",        limit: 255,   default: "trail"
    t.string   "account_status",         limit: 255,   default: "pending"
  end

  add_index "recruiters", ["email"], name: "index_recruiters_on_email", unique: true, using: :btree
  add_index "recruiters", ["reset_password_token"], name: "index_recruiters_on_reset_password_token", unique: true, using: :btree

  create_table "test", id: false, force: :cascade do |t|
    t.string "name",  limit: 50
    t.string "email", limit: 150, default: "test"
  end

  create_table "trainers", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "",             null: false
    t.string   "encrypted_password",     limit: 255,   default: "",             null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,              null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.string   "login_type",             limit: 80
    t.string   "full_name",              limit: 150
    t.string   "primary_number",         limit: 12
    t.date     "birth_date"
    t.string   "gender",                 limit: 30,    default: "not selected"
    t.text     "address",                limit: 65535
    t.string   "city",                   limit: 100
    t.string   "state",                  limit: 100
    t.string   "country",                limit: 150
    t.string   "profile_status",         limit: 100,   default: "pending"
    t.string   "subscribed_plan",        limit: 100,   default: "trail"
    t.date     "busy_from"
    t.date     "busy_till"
    t.string   "role",                   limit: 50,    default: "trainer"
  end

  add_index "trainers", ["email"], name: "index_trainers_on_email", unique: true, using: :btree
  add_index "trainers", ["reset_password_token"], name: "index_trainers_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "expertises", "trainers"
  add_foreign_key "qualifications", "trainers"
end
