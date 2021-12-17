module Mutations
  class SampleTvShow < BaseMutation
    argument :id, ID, required: true

    type Types::TvShowType

    def resolve(id:)
      show = Domain::Btn::TvShow.new(tv_show(id))
      SampleTvShowJob.perform_now(tv_show(id))
      show
    end

    def tv_show(id)
      if Services::Imdb.matches?(id)
        Domain::Btn::TvShow.create_from_imdb_id(id).__getobj__
      else
        TvShow.find(id)
      end
    end
  end
end
