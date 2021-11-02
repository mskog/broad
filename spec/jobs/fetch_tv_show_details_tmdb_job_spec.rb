require "spec_helper"

describe FetchTvShowDetailsTmdbJob do
  subject{described_class.new}

  When{subject.perform(tv_show)}

  Given(:tv_show){create :tv_show, name: "Hannibal", imdb_id: "test"}
  Then{expect(tv_show.tmdb_details["first_air_date"]).to eq "2021-10-08"}
end
