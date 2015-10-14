require 'spec_helper'

describe MovieDecorator, :nodb do
  subject{described_class.new(movie)}

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
end
