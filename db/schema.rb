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

ActiveRecord::Schema.define(version: 20170613190733) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "credentials", force: :cascade do |t|
    t.string   "name"
    t.hstore   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_credentials_on_name", unique: true, using: :btree
  end

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
    t.integer  "tv_show_id"
    t.text     "tmdb_details"
    t.datetime "download_at"
    t.boolean  "watched",      default: false
    t.index ["tv_show_id"], name: "index_episodes_on_tv_show_id", using: :btree
  end

  create_table "movie_recommendations", force: :cascade do |t|
    t.string   "title"
    t.integer  "year"
    t.string   "imdb_id"
    t.string   "trakt_id"
    t.string   "tmdb_id"
    t.string   "trakt_slug"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.float    "trakt_rating"
    t.date     "release_date"
    t.integer  "runtime"
    t.string   "language"
    t.string   "genres",                     array: true
    t.string   "certification"
    t.string   "overview"
    t.index ["imdb_id"], name: "index_movie_recommendations_on_imdb_id", using: :btree
    t.index ["tmdb_id"], name: "index_movie_recommendations_on_tmdb_id", using: :btree
    t.index ["trakt_id"], name: "index_movie_recommendations_on_trakt_id", using: :btree
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
    t.bigint   "size"
    t.integer  "snatched"
    t.string   "source"
    t.boolean  "scene"
    t.datetime "upload_time"
    t.string   "auth_key"
    t.string   "remaster_title"
    t.string   "version_attributes", default: [], array: true
  end

  create_table "movies", force: :cascade do |t|
    t.string   "title"
    t.string   "imdb_id"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "waitlist",      default: false
    t.datetime "download_at"
    t.boolean  "watched",       default: false
    t.string   "tmdb_id"
    t.string   "trakt_id"
    t.string   "trakt_slug"
    t.float    "trakt_rating"
    t.date     "release_date"
    t.integer  "runtime"
    t.string   "language"
    t.string   "genres",                        array: true
    t.string   "certification"
    t.string   "overview"
    t.datetime "watched_at"
  end

  create_table "tv_shows", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "tmdb_details"
    t.text     "trakt_details"
    t.string   "imdb_id"
    t.index ["imdb_id"], name: "index_tv_shows_on_imdb_id", unique: true, using: :btree
  end

end
