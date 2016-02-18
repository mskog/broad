class MovieRelease < ActiveRecord::Base
  belongs_to :movie, touch: true
end
