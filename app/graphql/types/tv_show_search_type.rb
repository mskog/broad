module Types
  class TvShowSearchType < Types::BaseObject
    field :title, String, null: false
    field :year, Integer, null: true
    field :overview, String, null: true
    field :imdb_id, String, null: true
    field :tmdb_id, String, null: true
    field :tvdb_id, String, null: true
    field :imdb_url, String, null: true
    field :exists, Boolean, null: true
    field :existing_tv_show_id, Integer, null: true

    field :details, Types::TvShowDetailsType, null: true

    def details
      Services::Trakt::Shows.new.summary(object.imdb_id)
    end
  end
end
