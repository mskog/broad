# typed: false
class AddDownloadedToMovieReleases < ActiveRecord::Migration[5.2]
  def change
    add_column :movie_releases, :downloaded, :boolean, default: false

    Movie.find_each do |movie|
      movie.download
    end
  end
end
