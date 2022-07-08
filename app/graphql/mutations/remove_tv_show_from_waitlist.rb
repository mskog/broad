# typed: true
module Mutations
  class RemoveTvShowFromWaitlist < BaseMutation
    argument :id, ID, required: true

    type Types::TvShowType

    def resolve(id:)
      tv_show = ::TvShow.find(id)
      tv_show.update waitlist: false
      tv_show
    end
  end
end
