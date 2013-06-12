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

ActiveRecord::Schema.define(:version => 20130612192814) do

  create_table "attachment_links", :force => true do |t|
    t.integer  "user_id"
    t.integer  "attachment_id"
    t.integer  "risk_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "attachments", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "checklist_items", :force => true do |t|
    t.string   "title"
    t.boolean  "done"
    t.integer  "checklist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checklists", :force => true do |t|
    t.string   "title"
    t.integer  "risk_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :default => 0
    t.string   "commentable_type", :default => ""
    t.string   "title",            :default => ""
    t.text     "body",             :default => ""
    t.string   "subject",          :default => ""
    t.integer  "user_id",          :default => 0,     :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",          :default => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "impacts", :force => true do |t|
    t.string   "name"
    t.integer  "risk_level_id"
    t.integer  "risk_configuration_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hidden"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.integer  "risk_configuration_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "risk_asset_values", :force => true do |t|
    t.string   "name"
    t.integer  "weight"
    t.integer  "risk_configuration_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "description"
  end

  create_table "risk_assets", :force => true do |t|
    t.integer  "risk_asset_value_id"
    t.integer  "project_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "risk_assets", ["risk_asset_value_id"], :name => "index_assets_on_asset_value_id"

  create_table "risk_assets_risks", :id => false, :force => true do |t|
    t.integer "risk_id",       :null => false
    t.integer "risk_asset_id", :null => false
  end

  add_index "risk_assets_risks", ["risk_id", "risk_asset_id"], :name => "index_assets_risks_on_risk_id_and_asset_id", :unique => true

  create_table "risk_at_days", :force => true do |t|
    t.date     "date"
    t.integer  "total"
    t.integer  "accepted"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "risk_configurations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "risk_consequences", :force => true do |t|
    t.string   "name"
    t.integer  "weight"
    t.integer  "risk_configuration_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "risk_levels", :force => true do |t|
    t.string   "name"
    t.integer  "weight"
    t.integer  "risk_configuration_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color"
  end

  create_table "risk_probabilities", :force => true do |t|
    t.string   "name"
    t.integer  "weight"
    t.integer  "risk_configuration_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "risks", :force => true do |t|
    t.string   "title"
    t.text     "description",         :limit => 255
    t.integer  "project_id"
    t.integer  "risk_level_id"
    t.integer  "risk_consequence_id"
    t.integer  "risk_probability_id"
    t.integer  "impact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "accepted_override"
    t.string   "threat_agent"
    t.text     "mitigation"
    t.string   "comment"
    t.boolean  "deleted",                            :default => false
    t.integer  "risk_id",             :limit => 255
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

# Could not dump table "users" because of following StandardError
#   Unknown type 'user' for column 'connected_to'

  create_table "versions", :force => true do |t|
    t.string   "item_type",      :null => false
    t.integer  "item_id",        :null => false
    t.string   "event",          :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["created_at"], :name => "index_versions_on_created_at"
  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
