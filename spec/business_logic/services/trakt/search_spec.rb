require 'spec_helper'

describe Services::Trakt::Search do
  subject{described_class.new}

  describe '#movies' do
    context "simple query" do
      Given do
        stub_request(:get, "https://api-v2launch.trakt.tv/search?query=deadpool&type=movie").to_return(body: JSON.parse(File.new('spec/fixtures/trakt/search/movies_deadpool.json').read))
      end

      Given(:query){'deadpool'}
      When(:result){subject.movies(query)}
      Given(:first_result){result.first}
      Then{expect(first_result.title).to eq 'Deadpool'}
      And{expect(first_result.year).to eq 2016}
      And{expect(first_result.overview).to start_with "Based upon"}
      And{expect(first_result.ids.trakt).to eq 190430}
      And{expect(first_result.ids.slug).to eq "deadpool-2016"}
      And{expect(first_result.ids.tmdb).to eq 293660}
      And{expect(first_result.ids.imdb).to eq "tt1431045"}
      And{expect(first_result.images.poster.full).to eq "https://walter.trakt.us/images/movies/000/190/430/posters/original/9a8494f868.jpg"}
      And{expect(first_result.images.poster.medium).to eq "https://walter.trakt.us/images/movies/000/190/430/posters/medium/9a8494f868.jpg"}
      And{expect(first_result.images.poster.thumb).to eq "https://walter.trakt.us/images/movies/000/190/430/posters/thumb/9a8494f868.jpg"}
      And{expect(first_result.images.fanart.full).to eq "https://walter.trakt.us/images/movies/000/190/430/fanarts/original/14af8cdb1a.jpg"}
      And{expect(first_result.images.fanart.medium).to eq "https://walter.trakt.us/images/movies/000/190/430/fanarts/medium/14af8cdb1a.jpg"}
      And{expect(first_result.images.fanart.thumb).to eq "https://walter.trakt.us/images/movies/000/190/430/fanarts/thumb/14af8cdb1a.jpg"}
    end

    context "with year" do
      Given do
        stub_request(:get, "https://api-v2launch.trakt.tv/search?query=deadpool&type=movie&year=#{year}").to_return(body: JSON.parse(File.new('spec/fixtures/trakt/search/movies_deadpool.json').read))
      end

      Given(:query){'deadpool'}
      Given(:year){2015}
      When(:result){subject.movies(query, year: year)}
      Then{expect(result.first.title).to eq 'Deadpool'}
    end
  end

  describe "#shows" do
    context "simple query" do
      Given do
        stub_request(:get, "https://api-v2launch.trakt.tv/search?query=Better%20Call%20Saul&type=show").to_return(body: JSON.parse(File.new('spec/fixtures/trakt/search/show_better_call_saul.json').read))
      end

      Given(:query){'Better Call Saul'}
      When(:result){subject.shows(query)}
      Given(:first_result){result.first}
      Then{expect(first_result.title).to eq 'Better Call Saul'}
      And{expect(first_result.year).to eq 2015}
      And{expect(first_result.overview).to start_with 'We meet him'}
      And{expect(first_result.status).to eq 'returning series'}
      And{expect(first_result.ids.trakt).to eq 59660}
      And{expect(first_result.ids.slug).to eq "better-call-saul"}
      And{expect(first_result.ids.tvdb).to eq 273181}
      And{expect(first_result.ids.imdb).to eq "tt3032476"}
      And{expect(first_result.ids.tmdb).to eq 60059}
      And{expect(first_result.ids.tvrage).to eq 37780}
      And{expect(first_result.images.poster.full).to eq 'https://walter.trakt.us/images/shows/000/059/660/posters/original/146359a178.jpg'}
      And{expect(first_result.images.poster.medium).to eq 'https://walter.trakt.us/images/shows/000/059/660/posters/medium/146359a178.jpg'}
      And{expect(first_result.images.poster.thumb).to eq 'https://walter.trakt.us/images/shows/000/059/660/posters/thumb/146359a178.jpg'}
      And{expect(first_result.images.fanart.full).to eq 'https://walter.trakt.us/images/shows/000/059/660/fanarts/original/a2deaec6b1.jpg'}
      And{expect(first_result.images.fanart.medium).to eq 'https://walter.trakt.us/images/shows/000/059/660/fanarts/medium/a2deaec6b1.jpg'}
      And{expect(first_result.images.fanart.thumb).to eq 'https://walter.trakt.us/images/shows/000/059/660/fanarts/thumb/a2deaec6b1.jpg'}
    end

    context "with year" do
      Given do
        stub_request(:get, "https://api-v2launch.trakt.tv/search?query=Better%20Call%20Saul&type=show&year=2015").to_return(body: JSON.parse(File.new('spec/fixtures/trakt/search/show_better_call_saul.json').read))
      end

      Given(:query){'Better Call Saul'}
      Given(:year){2015}
      When(:result){subject.shows(query, year: year)}
      Then{expect(result.first.title).to eq 'Better Call Saul'}
    end
  end

  describe "#id" do
    context "by imdb id" do
      Given do
        stub_request(:get, "https://api-v2launch.trakt.tv/search?id=#{id}&id_type=imdb").to_return(body: JSON.parse(File.new('spec/fixtures/trakt/search/movies_deadpool.json').read))
      end

      Given(:id){'tt1431045'}
      Given(:id_type){'imdb'}
      When(:result){subject.id(id, id_type: id_type)}
      Then{expect(result.first.title).to eq 'Deadpool'}
    end
  end
end
