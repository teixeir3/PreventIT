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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140221032604) do

  create_table "alert_settings", :force => true do |t|
    t.integer  "doctor_id",                              :null => false
    t.integer  "skipped_meds",         :default => 2,    :null => false
    t.integer  "skipped_appointments", :default => 2,    :null => false
    t.float    "a1c_min",              :default => 18.4, :null => false
    t.float    "a1c_max",              :default => 25.0, :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "skipped_treatments",   :default => 2,    :null => false
    t.integer  "skipped_inputs",       :default => 2,    :null => false
    t.float    "bmi_min",              :default => 18.0, :null => false
    t.float    "bmi_max",              :default => 30.0, :null => false
  end

  create_table "alerts", :force => true do |t|
    t.integer  "patient_id",                           :null => false
    t.string   "alert_type",                           :null => false
    t.boolean  "complete",          :default => false, :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "reminders_skipped"
    t.string   "reason"
  end

  add_index "alerts", ["patient_id"], :name => "index_alerts_on_patient_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0, :null => false
    t.integer  "attempts",   :default => 0, :null => false
    t.text     "handler",                   :null => false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "healths", :force => true do |t|
    t.integer  "patient_id", :null => false
    t.float    "height"
    t.float    "weight"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "healths", ["patient_id"], :name => "index_healths_on_patient_id"

  create_table "practices", :force => true do |t|
    t.string   "specialty",  :null => false
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reminders", :force => true do |t|
    t.datetime "datetime",                         :null => false
    t.string   "title",                            :null => false
    t.string   "rem_type",                         :null => false
    t.integer  "input"
    t.integer  "patient_id",                       :null => false
    t.boolean  "due",           :default => false, :null => false
    t.text     "note"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "checked",       :default => false, :null => false
    t.boolean  "complete"
    t.string   "sub_type"
    t.boolean  "input_checked", :default => false, :null => false
  end

  add_index "reminders", ["patient_id"], :name => "index_reminders_on_patient_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                  :null => false
    t.string   "password_digest",                        :null => false
    t.string   "session_token",                          :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.integer  "doctor_id"
    t.integer  "practice_id"
    t.boolean  "is_doctor",           :default => false, :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "email_notifications", :default => true,  :null => false
  end

  add_index "users", ["doctor_id"], :name => "index_users_on_doctor_id"

end
