require 'spec_helper'

describe "Movies", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env['ACCEPT'] = 'application/rss+xml'
  end

  Given do
    stub_request(:post, "https://tls.passthepopcorn.me/ajax.php?action=login").
             with(:body => {"passkey"=>ENV['PTP_PASSKEY'], "password"=>ENV['PTP_PASSWORD'], "username"=>ENV['PTP_USERNAME']})
             .to_return(:status => 200, :body => "", :headers => {})
  end

  describe "Create" do
    Given do
      stub_request(:get, "https://tls.passthepopcorn.me/torrents.php?json=noredirect&searchstr=tt0386064")
          .to_return(:status => 200, :body => File.read('spec/fixtures/ptp/brotherhood_of_war.json'))
    end

    When do
      post movie_downloads_path, params, @env
    end

    context "with valid parameters" do
      Given(:imdb_url){'http://www.imdb.com/title/tt0386064/?ref_=fn_al_tt_2'}
      Given(:params){{imdb_url: imdb_url}}

      Given(:expected_movie_release){MovieRelease.last}
      Then{expect(expected_movie_release).to be_present}
    end
  end

  describe "Index RSS" do
    Given!(:movie){create :movie, releases: create_list(:movie_release, 1)}

    Given do
      @env['ACCEPT'] = 'application/rss+xml'
    end

    Given(:feed_response){Feedjira::Feed.parse_with Feedjira::Parser::RSS, response.body}

    When do
      get movie_downloads_path, {}, @env
    end

    Given(:entry){feed_response.entries.last}

    Then{expect(entry.title).to eq movie.title.parameterize}
    And{expect(entry.url).to eq download_movie_download_url(movie.id, key: movie.key)}
  end
end
