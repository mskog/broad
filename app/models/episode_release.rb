class EpisodeRelease < ActiveRecord::Base
  belongs_to :episode, touch: true
end
