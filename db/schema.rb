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

ActiveRecord::Schema.define(version: 20170303202848) do

  create_table "cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "section_id"
    t.string   "title"
    t.string   "level"
    t.string   "chart_type"
    t.integer  "dataset_id"
    t.string   "column"
    t.string   "where_column"
    t.string   "where_equals"
    t.string   "action"
    t.text     "text",         limit: 65535
    t.integer  "order"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "datasets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "active"
    t.string   "term"
    t.string   "year"
    t.string   "name"
    t.integer  "permission"
    t.string   "csv"
    t.string   "base_path"
    t.string   "original_file"
    t.string   "yaml_file"
    t.string   "working_file"
    t.text     "columns",         limit: 65535
    t.text     "display_columns", limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "reports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
