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

ActiveRecord::Schema.define(:version => 20120605043307) do

  create_table "facebook_profiles", :force => true do |t|
    t.string  "email",                                       :null => false
    t.boolean "findable",                  :default => true, :null => false
    t.string  "first_name",  :limit => 60,                   :null => false
    t.text    "image_url"
    t.string  "last_name",   :limit => 60,                   :null => false
    t.string  "locale",      :limit => 10
    t.string  "middle_name", :limit => 60
    t.boolean "publishable",               :default => true, :null => false
    t.integer "timezone"
    t.string  "token",                                       :null => false
    t.string  "uid",                                         :null => false
    t.text    "profile_url"
    t.integer "user_id",                                     :null => false
  end

  add_index "facebook_profiles", ["email"], :name => "index_facebook_profiles_on_email", :unique => true
  add_index "facebook_profiles", ["findable"], :name => "index_facebook_profiles_on_findable"
  add_index "facebook_profiles", ["uid"], :name => "index_facebook_profiles_on_uid", :unique => true
  add_index "facebook_profiles", ["user_id"], :name => "index_facebook_profiles_on_user_id"

  create_table "invitations", :force => true do |t|
    t.datetime "accepted_at"
    t.string   "contact",     :limit => 80, :null => false
    t.string   "network",     :limit => 20, :null => false
    t.integer  "sender_id"
    t.datetime "sent_at"
    t.string   "state",       :limit => 20, :null => false
    t.string   "token",                     :null => false
  end

  add_index "invitations", ["accepted_at"], :name => "index_invitations_on_accepted_at"
  add_index "invitations", ["network", "token"], :name => "index_invitations_on_network_and_token"
  add_index "invitations", ["token"], :name => "index_invitations_on_token"

  create_table "roles", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "user_id", :null => false
    t.integer "role_id", :null => false
  end

  add_index "roles_users", ["user_id", "role_id"], :name => "index_roles_users_on_user_id_and_role_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "first_name",    :limit => 60, :null => false
    t.string   "last_name",     :limit => 60, :null => false
    t.string   "email",                       :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "invitation_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
