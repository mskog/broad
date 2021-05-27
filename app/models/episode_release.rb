class EpisodeRelease < ApplicationRecord
  belongs_to :episode, touch: true
end
