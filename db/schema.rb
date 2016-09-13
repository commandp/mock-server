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

ActiveRecord::Schema.define(version: 20160913090432) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_requests", force: :cascade do |t|
    t.string   "request_method"
    t.string   "request_path"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.json     "return_json"
    t.integer  "status_code"
    t.string   "name",           default: "", null: false
    t.text     "description",    default: "", null: false
    t.integer  "project_id"
    t.integer  "collection_id"
    t.index ["collection_id"], name: "index_api_requests_on_collection_id", using: :btree
    t.index ["project_id"], name: "index_api_requests_on_project_id", using: :btree
  end

  create_table "attachments", force: :cascade do |t|
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collections", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["project_id"], name: "index_collections_on_project_id", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "headers", force: :cascade do |t|
    t.string   "key"
    t.text     "value"
    t.integer  "api_request_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["api_request_id"], name: "index_headers_on_api_request_id", using: :btree
  end

  create_table "parameters", force: :cascade do |t|
    t.boolean  "required"
    t.string   "name",                        null: false
    t.text     "value",          default: ""
    t.string   "param_type",                  null: false
    t.integer  "api_request_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["api_request_id"], name: "index_parameters_on_api_request_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
    t.index ["slug"], name: "index_projects_on_slug", using: :btree
  end

  create_table "settings", force: :cascade do |t|
    t.string   "key",        null: false
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_settings_on_key", using: :btree
  end

  add_foreign_key "headers", "api_requests"
end
