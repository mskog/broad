# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_04_21_190002) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
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
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "credentials", id: :serial, force: :cascade do |t|
    t.string "name"
    t.hstore "data"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
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
    t.datetime "published_at", precision: nil
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "hdr", default: false
    t.boolean "downloaded", default: false
    t.boolean "dolby_vision", default: false
  end

  create_table "episodes", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "season_number"
    t.integer "episode"
    t.integer "year"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.datetime "published_at", precision: nil
    t.string "key"
    t.integer "tv_show_id"
    t.datetime "download_at", precision: nil
    t.boolean "watched", default: false
    t.date "air_date"
    t.datetime "watched_at", precision: nil
    t.jsonb "tmdb_details"
    t.integer "season_id"
    t.boolean "downloaded", default: false
    t.index ["tv_show_id"], name: "index_episodes_on_tv_show_id"
  end

  create_table "movie_releases", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
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
    t.datetime "upload_time", precision: nil
    t.string "auth_key"
    t.string "remaster_title"
    t.string "version_attributes", default: [], array: true
    t.boolean "downloaded", default: false
  end

  create_table "movies", id: :serial, force: :cascade do |t|
    t.string "title"
    t.string "imdb_id"
    t.string "key"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "waitlist", default: false
    t.datetime "download_at", precision: nil
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
    t.datetime "watched_at", precision: nil
    t.integer "rt_critics_rating"
    t.integer "personal_rating"
    t.integer "rt_audience_rating"
    t.date "available_date"
    t.jsonb "tmdb_images"
  end

  create_table "news_items", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "url"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "newsworthy_id"
    t.string "newsworthy_type"
    t.integer "score"
    t.json "metadata"
    t.string "category"
    t.index ["newsworthy_id", "newsworthy_type"], name: "index_news_items_on_newsworthy_id_and_newsworthy_type"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable"
  end

  create_table "seasons", force: :cascade do |t|
    t.bigint "tv_show_id"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "downloaded", default: false
    t.boolean "watched"
    t.index ["tv_show_id"], name: "index_seasons_on_tv_show_id"
  end

  create_table "tv_shows", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "imdb_id"
    t.integer "tvdb_id"
    t.boolean "watching", default: false
    t.boolean "collected", default: false
    t.string "status"
    t.boolean "waitlist", default: false
    t.jsonb "trakt_details"
    t.jsonb "tmdb_details"
    t.index ["imdb_id"], name: "index_tv_shows_on_imdb_id", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
