# typed: true
module Mutations
  class DownloadSeason < BaseMutation
    argument :tv_show_id, Integer, required: true
    argument :season_number, Integer, required: true

    type Types::TvShowType

    def resolve(tv_show_id:, season_number:)
      tv_show = ::TvShow.find(tv_show_id)
      tv_show.download_season(season_number)
    end
  end
end
