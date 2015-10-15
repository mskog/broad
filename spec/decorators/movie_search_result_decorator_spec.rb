require 'spec_helper'

describe MovieSearchResultDecorator, :nodb do
  subject{described_class.new(movie)}

  describe "#poster" do
    When(:result){subject.poster}

    context "with a poster" do
      Given(:movie){OpenStruct.new(poster: 'someimage.jpg')}
      Then{expect(result).to eq 'https://thumbs.picyo.me/200x0/filters:quality(50)/someimage.jpg'}
    end

    context "with no poster" do
      Given(:movie){OpenStruct.new(poster: 'N/A')}
      Then{expect(result).to eq 'https://www.fillmurray.com/300/444'}
    end
  end

  describe "#imdb_url" do
    Given(:movie){OpenStruct.new(imdb_id: 'tt232323')}
    When(:result){subject.imdb_url}
    Then{expect(result).to eq "http://www.imdb.com/title/#{movie.imdb_id}/"}
  end

  describe "#rt_url" do
    Given(:movie){OpenStruct.new(title: 'The Matrix')}
    When(:result){subject.rt_url}
    Then{expect(result).to eq "http://www.rottentomatoes.com/search/?search=#{movie.title}"}
  end
end
