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

ActiveRecord::Schema.define(:version => 20120125121548) do

  create_table "geometry_marks", :force => true do |t|
    t.string   "name"
    t.float    "radius"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.geometry "the_geom",   :limit => nil, :srid => 4269
    t.integer  "layer_id"
  end

  add_index "geometry_marks", ["the_geom"], :name => "index_geometry_marks_on_the_geom", :spatial => true

  create_table "layers", :force => true do |t|
    t.string   "name"
    t.string   "colour"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "point_marks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.point    "the_geom",   :limit => nil, :srid => 4269
    t.integer  "layer_id"
  end

  add_index "point_marks", ["the_geom"], :name => "index_point_marks_on_the_geom", :spatial => true

  create_table "points", :force => true do |t|
    t.string "description"
    t.point  "point",       :limit => nil, :srid => 4326
  end

  create_table "polygon_marks", :force => true do |t|
    t.string   "name"
    t.integer  "layer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.polygon  "the_geom",   :limit => nil, :srid => 4269
  end

  add_index "polygon_marks", ["the_geom"], :name => "index_polygon_marks_on_the_geom", :spatial => true

end
