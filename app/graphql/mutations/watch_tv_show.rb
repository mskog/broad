module Mutations
  class WatchTvShow < BaseMutation
    argument :id, ID, required: true

    type Types::TvShowType

    def resolve(id:)
      tv_show = TvShow.find(id)
      tv_show.update(watching: true)
      Domain::Btn::TvShow.new(tv_show)
    end
  end
end
