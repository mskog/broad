require 'spec_helper'

describe MovieDecorator, :nodb do
  Given(:domain_movie){Domain::PTP::Movie.new(movie)}
  subject{described_class.new(domain_movie)}

  describe "#poster" do
    Given(:movie){build_stubbed :movie, omdb_details: {'poster' => "someimage.jpg"}}
    When(:result){subject.poster}
    Then{expect(result).to eq 'https://thumbs.picyo.me/200x0/filters:quality(50)/someimage.jpg'}
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

  describe "#best_release" do
    Given(:movie){build_stubbed :movie, title: 'The Matrix', releases: [build_stubbed(:movie_release)]}
    When(:result){subject.best_release}
    Then{expect(result).to be_decorated_with(MovieReleaseDecorator)}
    And{expect(result).to eq movie.releases.last}
  end
end
