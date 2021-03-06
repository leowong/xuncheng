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

ActiveRecord::Schema.define(:version => 20110127053655) do

  create_table "assets", :force => true do |t|
    t.integer  "viewable_id"
    t.string   "viewable_type",           :limit => 50
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                    :limit => 50
    t.integer  "attachment_width"
    t.integer  "attachment_height"
    t.string   "post_type",               :limit => 50
    t.integer  "post_id"
    t.boolean  "used"
  end

  add_index "assets", ["viewable_type", "type", "viewable_id"], :name => "index_assets_on_viewable_type_and_type_and_viewable_id"

  create_table "callings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "types_mask"
  end

  add_index "callings", ["post_id"], :name => "index_callings_on_post_id"
  add_index "callings", ["user_id"], :name => "index_callings_on_user_id"

  create_table "groupings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "node_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groupings", ["node_id"], :name => "index_groupings_on_node_id"
  add_index "groupings", ["user_id"], :name => "index_groupings_on_user_id"

  create_table "nodes", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
  end

  add_index "nodes", ["name"], :name => "index_nodes_on_name", :unique => true

  create_table "nodings", :force => true do |t|
    t.integer  "node_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nodings", ["node_id"], :name => "index_nodings_on_node_id"
  add_index "nodings", ["topic_id"], :name => "index_nodings_on_topic_id"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "topic_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reply_counter"
    t.integer  "pageviews_count"
  end

  add_index "posts", ["topic_id", "reply_counter"], :name => "index_posts_on_topic_id_and_reply_counter"
  add_index "posts", ["topic_id"], :name => "index_posts_on_topic_id"
  add_index "posts", ["type"], :name => "index_posts_on_type"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                       :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",                            :default => "",    :null => false
    t.string   "signature"
    t.text     "biography"
    t.boolean  "email_publishing",                    :default => false
    t.integer  "roles_mask"
    t.string   "locale"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
