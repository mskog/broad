class AddAuthKeyToMovieRelease < ActiveRecord::Migration
  def change
    add_column :movie_releases, :auth_key, :string
  end
end
