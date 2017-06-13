require 'spec_helper'

describe MovieDecorator, :nodb do
  Given(:domain_movie){Domain::PTP::Movie.new(movie)}
  subject{described_class.new(domain_movie)}

  describe "#poster" do
    When(:result){subject.poster}

    context "with a set tmdb_id" do
      Given(:movie){build_stubbed :movie, tmdb_id: 49}
      Then{expect(result).to include "movie_posters/49"}
    end

    context "with a N/A poster" do
      Given(:movie){build_stubbed :movie}
      Then{expect(result).to eq h.image_url('murray_200x307.jpg')}
    end
  end

  describe "#imdb_url" do
    Given(:movie){build_stubbed :movie, imdb_id: 'tt232323'}
    When(:result){subject.imdb_url}
    Then{expect(result).to eq "http://www.imdb.com/title/#{movie.imdb_id}/"}
  end

  describe "#release_date_year" do
    When(:result){subject.release_date_year}

    context "with no release_date" do
      Given(:movie){build_stubbed :movie}
      Then{expect(result).to eq "-"}
    end

    context "with a release date" do
      Given(:movie){build_stubbed :movie, release_date: Date.parse('2015-01-01')}
      Then{expect(result).to eq 2015}
    end
  end

  describe "#genres" do
    When(:result){subject.genres}

    context "with no genres" do
      Given(:movie){build_stubbed :movie, genres: nil}
      Then{expect(result).to eq "-"}
    end

    context "with genres" do
      Given(:movie){build_stubbed :movie, genres: ['action', 'adventure']}
      Then{expect(result).to eq "Action, Adventure"}
    end
  end

  describe "#runtime" do
    When(:result){subject.runtime}

    context "with no runtime" do
      Given(:movie){build_stubbed :movie, runtime: nil}
      Then{expect(result).to eq "-"}
    end

    context "with a runtime" do
      Given(:movie){build_stubbed :movie, runtime: "128"}
      Then{expect(result).to eq "2h 8m"}
    end
  end

  describe "#watched_at" do
    When(:result){subject.watched_at}

    context "with no watched_at" do
      Given(:movie){build_stubbed :movie, watched_at: nil}
      Then{expect(result).to eq "-"}
    end

    context "with watched_at" do
      Given(:movie){build_stubbed :movie, watched_at: DateTime.parse("2015-01-01")}
      Then{expect(result).to eq "2015-01-01"}
    end

  end

  describe "#best_release" do
    When(:result){subject.best_release}

    context "with a movie with no releases" do
      Given(:movie){build_stubbed :movie, title: 'The Matrix'}
      Then{expect(result).to be_nil}
    end

    context "with a movie with releases" do
      Given(:movie){build_stubbed :movie, title: 'The Matrix', releases: [build_stubbed(:movie_release)]}
      Then{expect(result).to be_decorated_with(MovieReleaseDecorator)}
      And{expect(result).to eq movie.releases.last}
    end
  end

  describe "#forcable" do
    context "with a movie on waitlist with download_at earlier than now" do
      Given(:movie){build_stubbed :movie, waitlist: true, download_at: Time.now-1.hour}
      Then{expect(subject).to_not be_forcable}
    end

    context "with a movie on waitlist with download_at later than now" do
      Given(:movie){build_stubbed :movie, waitlist: true, download_at: Time.now+1.hour}
      Then{expect(subject).to be_forcable}
    end

    context "with a movie on waitlist with no download_at" do
      Given(:movie){build_stubbed :movie, waitlist: true, download_at: nil}
      Then{expect(subject).to_not be_forcable}
    end

    context "with a movie not on waitlist with download_at in the future" do
      Given(:movie){build_stubbed :movie, download_at: Time.now+1.hour, waitlist: false}
      Then{expect(subject).to_not be_forcable}
    end
  end
end
