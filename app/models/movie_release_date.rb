class MovieReleaseDate < ApplicationRecord
	belongs_to :movie

	scope :upcoming, -> { where("release_date >= current_date") }
end
