module Mutations
  class UnwatchTvShow < BaseMutation
    argument :id, ID, required: true

    type Types::TvShowType

    def resolve(id:)
      tv_show = TvShow.find(id)
      tv_show.update_attributes(watching: false)
      Domain::BTN::TvShow.new(tv_show)
    end
  end
end
