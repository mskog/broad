module Mutations
  class WatchTvShow < BaseMutation
    argument :id, ID, required: true

    type Types::TvShowType

    def resolve(id:)
      TvShow.find(id).watch
    end
  end
end
