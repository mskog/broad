class ChangeSerializedFieldsToJjsonB < ActiveRecord::Migration[7.0]
  def up
    add_column :movies, :tmdb_images_jsonb, :jsonb
    add_column :episodes, :tmdb_details_jsonb, :jsonb
    add_column :tv_shows, :trakt_details_jsonb, :jsonb
    add_column :tv_shows, :tmdb_details_jsonb, :jsonb

    Movie.find_each do |movie|
      movie.tmdb_images_jsonb = movie.tmdb_images
      movie.save!
    end

    Episode.find_each do |episode|
      episode.tmdb_details_jsonb = episode.tmdb_details
      episode.save!
    end

    TvShow.find_each do |tv_show|
      tv_show.tmdb_details_jsonb = tv_show.tmdb_details
      tv_show.trakt_details_jsonb = tv_show.trakt_details
      tv_show.save!
    end

    remove_column :movies, :tmdb_images
    remove_column :episodes, :tmdb_details
    remove_column :tv_shows, :tmdb_details
    remove_column :tv_shows, :trakt_details

    rename_column :movies, :tmdb_images_jsonb, :tmdb_images
    rename_column :tv_shows, :tmdb_details_jsonb, :tmdb_details
    rename_column :tv_shows, :trakt_details_jsonb, :trakt_details
    rename_column :episodes, :tmdb_details_jsonb, :tmdb_details
  end

  def down
    remove_column :movies, :tmdb_images_jsonb
    remove_column :episodes, :tmdb_details_jsonb
    remove_column :tv_shows, :tmdb_details_jsonb
    remove_column :tv_shows, :trakt_details_jsonb
  end
end
