module Mutations
  class SampleTvShow < BaseMutation
    argument :id, ID, required: true

    type Types::TvShowType

    def resolve(id:)
      show = Domain::BTN::TvShow.new(tv_show(id))
      SampleTvShowJob.perform_later(tv_show(id))
      TvShowDecorator.decorate(ViewObjects::TvShow.new(show))
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
