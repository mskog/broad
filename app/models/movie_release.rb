class MovieRelease < ApplicationRecord
  belongs_to :movie, touch: true
end
