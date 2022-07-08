# typed: true
class AddReleaseTitleAndVersionAttributesToMovieReleases < ActiveRecord::Migration[5.0]
  def change
    add_column :movie_releases, :remaster_title, :string
    add_column :movie_releases, :version_attributes, :string, array: true, default: []
  end
end
