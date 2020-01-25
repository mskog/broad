module Types
  class TvShowType < Types::BaseObject
    field :id, Integer, null: false
    field :name, String, null: false
    field :tmdbId, String, null: true
    field :imdbId, String, null: true
    field :watching, Boolean, null: true
    field :collected, Boolean, null: true
    field :status, String, null: true

    field :tmdb_details, Types::TvShowTmdbDetailsType, null: true
    field :trakt_details, Types::TraktDetailsType, null: true

    field :episodes, [Types::EpisodeType], null: true

    def episodes
      EpisodeDecorator.decorate_collection ViewObjects::Episodes.new(Episode.with_release.where(tv_show_id: object.id).order(id: :desc))
    end
  end
end
