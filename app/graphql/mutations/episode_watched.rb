module Mutations
  class EpisodeWatched < BaseMutation
    argument :id, ID, required: true

    type Types::EpisodeType

    def resolve(id:)
      episode = Episode.find(id)
      episode.update watched: true, watched_at: DateTime.current
      episode
    end
  end
end
