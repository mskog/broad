require "spec_helper"

describe EpisodeDecorator, :nodb do
  Given(:tmdb_details){{}}
  Given(:tv_show){build_stubbed :tv_show}
  Given(:episode){build_stubbed :episode, tmdb_details: tmdb_details, tv_show: tv_show}
  subject{described_class.new(episode)}

  describe "#season_episode" do
    When(:result){subject.season_episode}

    context "with a single digit season and episode" do
      Given(:episode){build_stubbed :episode, season: 9, episode: 1}
      Then{expect(result).to eq "S09E01"}
    end

    context "with multiple digit season and episode" do
      Given(:episode){build_stubbed :episode, season: 992, episode: 122}
      Then{expect(result).to eq "S992E122"}
    end
  end

  describe "#still" do
    Given(:tmdb_details){{"still_path" => "/sdfsfsd.jpg"}}

    context "with no tmdb details and no tv show details" do
      Given(:tmdb_details){nil}
      When(:result){subject.still}
      Then{expect(result).to eq h.image_url("murray_300x169.jpg")}
    end

    context "with no tmdb details but show details" do
      Given(:tmdb_details){nil}
      Given(:tv_show){build_stubbed :tv_show, tmdb_details: {"backdrop_path" => "/sdfsfsd.jpg"}}
      When(:result){subject.still}
      Then{expect(result).to eq "https://image.tmdb.org/t/p/original#{tv_show.tmdb_details['backdrop_path']}"}
    end

    context "with no still available" do
      When(:result){subject.still}
      Given(:tmdb_details){{}}
      Then{expect(result).to eq h.image_url("murray_300x169.jpg")}
    end
  end
end
