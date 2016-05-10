require 'spec_helper'

describe MovieDecorator, :nodb do
  Given(:domain_movie){Domain::PTP::Movie.new(movie)}
  subject{described_class.new(domain_movie)}

  describe "#poster" do
    When(:result){subject.poster}

    context "with a set poster" do
      Given(:movie){build_stubbed :movie, omdb_details: {'poster' => "someimage.jpg"}}
      Then{expect(result).to eq 'https://thumbs.picyo.me/700x0/someimage.jpg'}
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

  describe "#rt_consensus" do
    When(:result){subject.rt_consensus}

    context "with no consensus" do
      Given(:movie){build_stubbed :movie, omdb_details: {tomato_consensus: ""}}
      Then{expect(result).to eq ''}
    end

    context "with N/A consensus" do
      Given(:movie){build_stubbed :movie, omdb_details: {tomato_consensus: "N/A"}}
      Then{expect(result).to eq ''}
    end

    context "with consensus" do
      Given(:movie){build_stubbed :movie, omdb_details: {tomato_consensus: "kebab"}}
      Then{expect(result).to eq '"kebab"'}
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

  describe "#release_date" do
    When(:result){subject.release_date}

    context "with no details" do
      Given(:movie){build_stubbed :movie, omdb_details: nil}
      Then{expect(result).to eq '-'}
    end

    context "with details" do
      Given(:released){'21 Jul 2014'}
      Given(:movie){build_stubbed :movie, omdb_details: {released: released}}
      Then{expect(result).to eq Date.parse(released)}
    end

    context "with invalid date in details" do
      Given(:released){'N/A'}
      Given(:movie){build_stubbed :movie, omdb_details: {released: released}}
      Then{expect(result).to eq '-'}
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
