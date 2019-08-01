require "spec_helper"

describe FetchTvShowDetailsTmdbJob do
  subject{described_class.new}

  When{subject.perform(tv_show)}

  context "with an existing show" do
    Given(:tv_show){create :tv_show, name: "Hannibal"}
    Then{expect(tv_show.tmdb_details["first_air_date"]).to eq "2013-04-04"}
  end

  context "with an existing show with year" do
    Given(:tv_show){create :tv_show, name: "Hannibal (2015)"}
    Then{expect(tv_show.tmdb_details["first_air_date"]).to eq "2013-04-04"}
  end

  context "with a missing show" do
    Given(:tv_show){create :tv_show, name: "nofound"}
    Then{expect(tv_show.tmdb_details).to_not be_present}
  end
end
