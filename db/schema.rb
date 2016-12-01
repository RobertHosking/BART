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

ActiveRecord::Schema.define(version: 20161129155117) do

  create_table "cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "page_id"
    t.string   "title"
    t.integer  "permission"
    t.boolean  "visible"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "datasets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "active"
    t.boolean  "raw"
    t.string   "term"
    t.string   "year"
    t.string   "name"
    t.integer  "permission"
    t.string   "csv"
    t.string   "base_path"
    t.string   "original_file"
    t.string   "yaml_file"
    t.string   "working_file"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "entries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "dataset_id"
    t.string   "employeeNo"
    t.string   "evaluatorNo"
    t.string   "positionName"
    t.string   "smartEvalsPositionID"
    t.string   "companyPositionID"
    t.string   "division"
    t.string   "dept"
    t.string   "departmentLong"
    t.string   "positionNum"
    t.string   "wlsLevel"
    t.integer  "positionLevel"
    t.string   "positionTrait"
    t.integer  "positionYear"
    t.string   "positionSemester"
    t.integer  "positionSection"
    t.string   "evaluateeFirstName"
    t.string   "evaluateeMiddleName"
    t.string   "evaluateeLastName"
    t.string   "surveyBeginDate"
    t.string   "surveyEndDate"
    t.string   "surveyCompleteDate"
    t.string   "employeeOrPostion?"
    t.integer  "i40355"
    t.integer  "i40367"
    t.integer  "i40360"
    t.integer  "i40370"
    t.integer  "i40372"
    t.integer  "i40375"
    t.integer  "i40378"
    t.integer  "i59526"
    t.text     "attendance",           limit: 65535
    t.text     "accountability",       limit: 65535
    t.text     "teamwork",             limit: 65535
    t.text     "initiative",           limit: 65535
    t.text     "respect",              limit: 65535
    t.text     "learning",             limit: 65535
    t.text     "jobSpecific",          limit: 65535
    t.string   "s40874"
    t.string   "s40875"
    t.string   "s65452"
    t.string   "s65453"
    t.string   "raceOfSupervisor"
    t.string   "gender"
    t.integer  "age"
    t.string   "esl"
    t.string   "partTimeFullTime"
    t.string   "creditHours"
    t.string   "positionStatus"
    t.string   "instructorTenured"
    t.string   "major"
    t.string   "gradeID"
    t.string   "advisorBnum"
    t.string   "advisorLastName"
    t.string   "transferStudent"
    t.string   "inState"
    t.string   "gpaSoFar"
    t.integer  "weekDropped"
    t.string   "timeline"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "pages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "section_id"
    t.string   "name"
    t.integer  "permission"
    t.boolean  "visible"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "dataset_id"
    t.string   "name"
    t.integer  "access"
    t.boolean  "visible"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
