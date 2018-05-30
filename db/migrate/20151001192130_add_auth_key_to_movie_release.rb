class AddAuthKeyToMovieRelease < ActiveRecord::Migration[5.0]
  def change
    add_column :movie_releases, :auth_key, :string
  end
end
