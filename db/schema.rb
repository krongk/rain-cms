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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150725155624) do

  create_table "admin_channels", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "parent_id",   limit: 4
    t.string   "typo",        limit: 255
    t.string   "title",       limit: 255
    t.string   "short_title", limit: 255
    t.string   "properties",  limit: 255
    t.string   "default_url", limit: 255
    t.string   "tmp_index",   limit: 255
    t.string   "tmp_list",    limit: 255
    t.string   "tmp_detail",  limit: 255
    t.string   "keywords",    limit: 255
    t.string   "description", limit: 255
    t.text     "content",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_path",  limit: 255
  end

  add_index "admin_channels", ["short_title"], name: "index_admin_channels_on_short_title", unique: true, using: :btree
  add_index "admin_channels", ["title"], name: "index_admin_channels_on_title", unique: true, using: :btree
  add_index "admin_channels", ["user_id"], name: "index_admin_channels_on_user_id", using: :btree

  create_table "admin_comments", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "mobile_phone", limit: 255
    t.string   "tel_phone",    limit: 255
    t.string   "email",        limit: 255
    t.string   "qq",           limit: 255
    t.string   "address",      limit: 255
    t.string   "gender",       limit: 255
    t.date     "birth"
    t.string   "hobby",        limit: 255
    t.text     "content",      limit: 65535
    t.text     "content2",     limit: 65535
    t.text     "content3",     limit: 65535
    t.string   "status",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_forages", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.text     "content",      limit: 65535
    t.string   "tag",          limit: 255
    t.string   "author",       limit: 255
    t.string   "original_url", limit: 255
    t.string   "image_url",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_keystores", force: :cascade do |t|
    t.string   "key",         limit: 255
    t.string   "value",       limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_keystores", ["key"], name: "index_admin_keystores_on_key", using: :btree

  create_table "admin_pages", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "channel_id",   limit: 4
    t.string   "title",        limit: 255
    t.string   "short_title",  limit: 255
    t.string   "properties",   limit: 255
    t.string   "keywords",     limit: 255
    t.string   "description",  limit: 255
    t.string   "image_path",   limit: 255
    t.text     "content",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price",                      precision: 8,  scale: 2
    t.decimal  "discount",                   precision: 10
    t.string   "unit",         limit: 255
    t.integer  "amount",       limit: 4
    t.string   "external_url", limit: 255
  end

  add_index "admin_pages", ["channel_id"], name: "index_admin_pages_on_channel_id", using: :btree
  add_index "admin_pages", ["short_title"], name: "index_admin_pages_on_short_title", using: :btree
  add_index "admin_pages", ["user_id"], name: "index_admin_pages_on_user_id", using: :btree

  create_table "admin_properties", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "admin_properties", ["name"], name: "index_admin_properties_on_name", unique: true, using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "cate_id",        limit: 4
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["cate_id"], name: "index_tags_on_cate_id", using: :btree
  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
