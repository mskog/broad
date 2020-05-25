module Mutations
  class CollectTvShow < BaseMutation
    argument :id, ID, required: true

    type Types::TvShowType

    def resolve(id:)
      show = tv_show(id)
      show.update(collected: true, watching: true)
      CollectTvShowJob.perform_later(show)
      Domain::BTN::TvShow.new(show)
    end

    def tv_show(id)
      if Services::Imdb.matches?(id)
        Domain::BTN::TvShow.create_from_imdb_id(id).__getobj__
      else
        TvShow.find(id)
      end
    end
  end
end
