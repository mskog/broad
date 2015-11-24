require 'spec_helper'

describe MovieDecorator, :nodb do
  Given(:domain_movie){Domain::PTP::Movie.new(movie)}
  subject{described_class.new(domain_movie)}

  describe "#poster" do
    When(:result){subject.poster}

    context "with a set poster" do
      Given(:movie){build_stubbed :movie, omdb_details: {'poster' => "someimage.jpg"}}
      Then{expect(result).to eq 'https://thumbs.picyo.me/200x0/filters:quality(50)/someimage.jpg'}
    end

    context "with a N/A poster" do
      Given(:movie){build_stubbed :movie, omdb_details: {'poster' => 'N/A'}}
      Then{expect(result).to eq h.image_url('murray_200x307.jpg')}
    end
  end

  describe "#imdb_url" do
    Given(:movie){build_stubbed :movie, imdb_id: 'tt232323'}
    When(:result){subject.imdb_url}
    Then{expect(result).to eq "http://www.imdb.com/title/#{movie.imdb_id}/"}
  end

  describe "#rt_url" do
    Given(:movie){build_stubbed :movie, title: 'The Matrix'}
    When(:result){subject.rt_url}
    Then{expect(result).to eq "http://www.rottentomatoes.com/search/?search=#{movie.title}"}
  end

  describe "#rt_icon" do
    When(:result){subject.rt_icon}

    context "with no rotten tomatoes score" do
      Given(:movie){build_stubbed :movie, omdb_details: {tomato_meter: "N/A"}}
      Then{expect(result).to eq 'rt_fresh.png'}
    end

    context "with a 'fresh' movie" do
      Given(:movie){build_stubbed :movie, omdb_details: {tomato_meter: 65}}
      Then{expect(result).to eq 'rt_fresh.png'}
    end

    context "with a 'rotten' movie" do
      Given(:movie){build_stubbed :movie, omdb_details: {tomato_meter: 20}}
      Then{expect(result).to eq 'rt_rotten.png'}
    end

  end

  describe "#best_release" do
    Given(:movie){build_stubbed :movie, title: 'The Matrix', releases: [build_stubbed(:movie_release)]}
    When(:result){subject.best_release}
    Then{expect(result).to be_decorated_with(MovieReleaseDecorator)}
    And{expect(result).to eq movie.releases.last}
  end
end
