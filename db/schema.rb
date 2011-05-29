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

ActiveRecord::Schema.define(:version => 20110529103200) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "risk_level_id"
    t.integer  "risk_configuration_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.integer  "risk_configuration_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  create_table "risk_levels", :force => true do |t|
    t.string   "name"
    t.integer  "weight"
    t.integer  "risk_configuration_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "risk_probabilities", :force => true do |t|
    t.string   "name"
    t.integer  "weight"
    t.integer  "risk_configuration_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "risks", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "project_id"
    t.integer  "risk_level_id"
    t.integer  "risk_consequence_id"
    t.integer  "risk_probability_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "accepted_override"
  end

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
