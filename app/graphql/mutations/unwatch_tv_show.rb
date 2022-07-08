# typed: true
module Mutations
  class UnwatchTvShow < BaseMutation
    argument :id, ID, required: true

    type Types::TvShowType

    def resolve(id:)
      TvShow.find(id).unwatch
    end
  end
end
