module Types
  class SeasonType < Types::BaseObject
    field :id, Integer, null: false
    field :number, Integer, null: false
    field :download_requested, Boolean, null: false
    field :downloaded, Boolean, null: false
    field :watched, Boolean, null: false
    field :aired, Boolean, null: false

    field :tv_show, Types::TvShowType, null: false
    field :episodes, [Types::EpisodeType], null: false

    def aired
      object.aired?
    end
  end
end
