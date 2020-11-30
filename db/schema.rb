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

ActiveRecord::Schema.define(version: 2020_11_30_184503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "credentials", id: :serial, force: :cascade do |t|
    t.string "name"
    t.hstore "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_credentials_on_name", unique: true
  end

  create_table "episode_releases", id: :serial, force: :cascade do |t|
    t.integer "episode_id"
    t.string "title"
    t.string "url"
    t.string "file_type"
    t.string "file_encoding"
    t.string "source"
    t.string "resolution"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "episodes", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "season"
    t.integer "episode"
    t.integer "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.string "key"
    t.integer "tv_show_id"
    t.text "tmdb_details"
    t.datetime "download_at"
    t.boolean "watched", default: false
    t.date "air_date"
    t.datetime "watched_at"
    t.index ["tv_show_id"], name: "index_episodes_on_tv_show_id"
  end

  create_table "movie_recommendations", id: :serial, force: :cascade do |t|
    t.string "title"
    t.integer "year"
    t.string "imdb_id"
    t.string "trakt_id"
    t.string "tmdb_id"
    t.string "trakt_slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "trakt_rating"
    t.date "release_date"
    t.integer "runtime"
    t.string "language"
    t.string "genres", array: true
    t.string "certification"
    t.string "overview"
    t.index ["imdb_id"], name: "index_movie_recommendations_on_imdb_id"
    t.index ["tmdb_id"], name: "index_movie_recommendations_on_tmdb_id"
    t.index ["trakt_id"], name: "index_movie_recommendations_on_trakt_id"
  end

  create_table "movie_releases", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "movie_id"
    t.integer "ptp_movie_id"
    t.boolean "checked"
    t.string "codec"
    t.string "container"
    t.boolean "golden_popcorn"
    t.integer "leechers"
    t.integer "seeders"
    t.string "quality"
    t.string "release_name"
    t.string "resolution"
    t.bigint "size"
    t.integer "snatched"
    t.string "source"
    t.boolean "scene"
    t.datetime "upload_time"
    t.string "auth_key"
    t.string "remaster_title"
    t.string "version_attributes", default: [], array: true
    t.boolean "downloaded", default: false
  end

  create_table "movies", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "imdb_id"
    t.string "key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "waitlist", default: false
    t.datetime "download_at"
    t.boolean "watched", default: false
    t.string "tmdb_id"
    t.string "trakt_id"
    t.string "trakt_slug"
    t.float "trakt_rating"
    t.date "release_date"
    t.integer "runtime"
    t.string "language"
    t.string "genres", array: true
    t.string "certification"
    t.string "overview"
    t.datetime "watched_at"
    t.integer "rt_critics_rating"
    t.integer "personal_rating"
    t.integer "rt_audience_rating"
    t.jsonb "tmdb_images", default: {}, null: false
  end

  create_table "news_items", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "newsworthy_id"
    t.string "newsworthy_type"
    t.integer "score"
    t.json "metadata"
    t.string "category"
    t.index ["newsworthy_id", "newsworthy_type"], name: "index_news_items_on_newsworthy_id_and_newsworthy_type"
  end

  create_table "tv_shows", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "tmdb_details"
    t.text "trakt_details"
    t.string "imdb_id"
    t.integer "tvdb_id"
    t.boolean "watching", default: false
    t.boolean "collected", default: false
    t.string "status"
    t.boolean "waitlist", default: false
    t.index ["imdb_id"], name: "index_tv_shows_on_imdb_id", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
