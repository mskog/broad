require 'spec_helper'

describe TvShowDecorator, :nodb do
  Given(:tmdb_details){{}}
  Given(:tv_show){create :tv_show, tmdb_details: tmdb_details, episodes: [create(:episode), create(:episode, :aired)]}
  Given(:object){ViewObjects::TvShow.new(tv_show)}
  subject{described_class.new(object)}

  describe "Associations" do
    Then{expect(subject.episodes.first).to be_decorated_with(EpisodeDecorator)}
    Then{expect(subject.aired_episodes.first).to be_decorated_with(EpisodeDecorator)}
  end

  describe "#poster" do
    Given(:tmdb_details){{"poster_path" => '/sdfsfsd.jpg'}}

    context "with default size" do
      When(:result){subject.poster}
      Then{expect(result).to eq "https://image.tmdb.org/t/p/w300#{tmdb_details['poster_path']}"}
    end

    context "with poster size 300" do
      When(:result){subject.poster(poster_size)}
      Given(:poster_size){300}
      Then{expect(result).to eq "https://image.tmdb.org/t/p/w300#{tmdb_details['poster_path']}"}
    end

    context "with no poster available" do
      When(:result){subject.poster(poster_size)}
      Given(:tmdb_details){{}}
      Given(:poster_size){300}
      Then{expect(result).to eq h.image_url('murray_300x169.jpg')}
    end
  end

  describe "#backdrop" do
    Given(:tmdb_details){{"backdrop_path" => '/sdfsfsd.jpg'}}

    When(:result){subject.backdrop}
    Then{expect(result).to eq "https://image.tmdb.org/t/p/original/#{tmdb_details['backdrop_path']}"}
  end

  describe "#imdb_url" do
    When(:result){subject.imdb_url}

    context "with no imdb id" do
      Given(:tv_show){create :tv_show, imdb_id: nil}
      Then{expect(result).to eq ''}
    end

    context "with imdb id" do
      Given(:tv_show){create :tv_show, imdb_id: "tt7902072"}
      Then{expect(result).to eq 'http://www.imdb.com/title/tt7902072/'}
    end
  end
end
