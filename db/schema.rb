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

ActiveRecord::Schema.define(:version => 20130810081553) do

  create_table "nodes", :force => true do |t|
    t.float    "lat"
    t.float    "long"
    t.integer  "poi_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pairs", :force => true do |t|
    t.integer  "n1"
    t.integer  "n2"
    t.integer  "route_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "park_aliases", :force => true do |t|
    t.string   "name"
    t.integer  "park_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "parks", :force => true do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "long"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "description"
    t.integer  "zoom"
  end

  create_table "poi_types", :force => true do |t|
    t.string   "name"
    t.string   "icon"
    t.string   "highlight"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "parameter"
    t.integer  "size"
  end

  create_table "pois", :force => true do |t|
    t.float    "lat"
    t.float    "long"
    t.string   "name"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.integer  "poi_type_id"
    t.integer  "park_id"
  end

  create_table "route_points", :force => true do |t|
    t.float    "lat"
    t.float    "long"
    t.integer  "height"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "route_id"
  end

  create_table "routes", :force => true do |t|
    t.string   "name"
    t.string   "color"
    t.integer  "number"
    t.integer  "maxHeight"
    t.integer  "minHeight"
    t.integer  "distance"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "gain"
    t.integer  "loss"
    t.string   "description"
    t.integer  "trail_id"
    t.integer  "park_id"
  end

  create_table "trails", :force => true do |t|
    t.string   "number"
    t.string   "name"
    t.string   "park"
    t.string   "color"
    t.float    "mileage"
    t.integer  "hike_use"
    t.integer  "horse_use"
    t.integer  "bike_use"
    t.integer  "snowshoe_use"
    t.integer  "cross_country_use"
    t.integer  "snowmobile_use"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "route_id"
    t.integer  "park_id"
  end

end
