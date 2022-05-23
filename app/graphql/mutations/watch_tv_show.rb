module Mutations
  class WatchTvShow < BaseMutation
    argument :id, ID, required: true

    type Types::TvShowType

    def resolve(id:)
      tv_show(id).watch
    end

    def tv_show(id)
      if Services::Imdb.matches?(id)
        TvShow.create_from_imdb_id(id)
      else
        TvShow.find(id)
      end
    end
  end
end
