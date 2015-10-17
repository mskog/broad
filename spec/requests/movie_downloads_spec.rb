require 'spec_helper'

describe "Movies", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env['ACCEPT'] = 'application/rss+xml'
  end

  describe "Create" do
    When do
      post movie_downloads_path, params, @env
    end

    context "with valid parameters" do
      Given(:imdb_url){'http://www.imdb.com/title/tt0386064/?ref_=fn_al_tt_2'}
      Given(:params){{query: imdb_url}}

      Given(:expected_movie){Movie.last}
      Given(:expected_movie_release){expected_movie.releases.last}
      Then{expect(expected_movie_release).to be_present}
      And{expect(expected_movie).to be_present}
    end
  end

  describe "Index RSS" do
    Given!(:movie){create :movie, releases: create_list(:movie_release, 1)}
    Given!(:movie_waitlist){create :movie, releases: create_list(:movie_release, 1), waitlist: true}

    Given do
      @env['ACCEPT'] = 'application/rss+xml'
    end

    Given(:feed_response){Feedjira::Feed.parse_with Feedjira::Parser::RSS, response.body}

    When do
      get movie_downloads_path, {}, @env
    end

    Given(:entry){feed_response.entries.last}

    Then{expect(feed_response.entries.count).to eq 1}
    And{expect(entry.title).to eq movie.title.parameterize}
    And{expect(entry.url).to eq download_movie_download_url(movie.id, key: movie.key)}
  end
end
