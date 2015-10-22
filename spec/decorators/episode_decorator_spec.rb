require 'spec_helper'

describe EpisodeDecorator do
  Given(:tmdb_details){{}}
  Given(:episode){build_stubbed :episode, tmdb_details: tmdb_details}
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
    Given(:tmdb_details){{"still_path" => '/sdfsfsd.jpg'}}

    context "with default size" do
      When(:result){subject.still}
      Then{expect(result).to eq "https://image.tmdb.org/t/p/w300#{tmdb_details['still_path']}"}
    end

    context "with still size 300" do
      When(:result){subject.still(still_size)}
      Given(:still_size){300}
      Then{expect(result).to eq "https://image.tmdb.org/t/p/w300#{tmdb_details['still_path']}"}
    end

    context "with no still available" do
      When(:result){subject.still(still_size)}
      Given(:tmdb_details){{}}
      Given(:still_size){300}
      Then{expect(result).to eq h.image_url('murray_300x169.jpg')}
    end
  end
end
