# typed: false
module Mutations
  class CollectTvShow < BaseMutation
    argument :id, ID, required: true

    type Types::TvShowType

    def resolve(id:)
      show = tv_show(id)
      show.update(collected: true, watching: true)
      CollectTvShowJob.perform_later(show)
      show
    end

    def tv_show(id)
      if Services::Imdb.matches?(id)
        ::TvShow.create_from_imdb_id(id)
      else
        TvShow.find(id)
      end
    end
  end
end
