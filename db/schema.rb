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

ActiveRecord::Schema.define(version: 20151011163312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "episode_releases", force: :cascade do |t|
    t.integer  "episode_id"
    t.string   "title"
    t.string   "url"
    t.string   "file_type"
    t.string   "file_encoding"
    t.string   "source"
    t.string   "resolution"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "episodes", force: :cascade do |t|
    t.string   "name"
    t.integer  "season"
    t.integer  "episode"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.string   "key"
  end

  create_table "movie_releases", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "movie_id"
    t.integer  "ptp_movie_id"
    t.boolean  "checked"
    t.string   "codec"
    t.string   "container"
    t.boolean  "golden_popcorn"
    t.integer  "leechers"
    t.integer  "seeders"
    t.string   "quality"
    t.string   "release_name"
    t.string   "resolution"
    t.integer  "size",               limit: 8
    t.integer  "snatched"
    t.string   "source"
    t.boolean  "scene"
    t.datetime "upload_time"
    t.string   "auth_key"
    t.string   "remaster_title"
    t.string   "version_attributes",           default: [], array: true
  end

  create_table "movies", force: :cascade do |t|
    t.string   "title"
    t.string   "imdb_id"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "omdb_details"
    t.boolean  "overwatch",    default: false
  end

end
