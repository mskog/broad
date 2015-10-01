require 'spec_helper'

describe "Movies", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env['ACCEPT'] = 'application/rss+xml'
  end

  Given do
    stub_request(:post, "https://tls.passthepopcorn.me/ajax.php?action=login").
             with(:body => {"passkey"=>ENV['PTP_PASSKEY'], "password"=>ENV['PTP_PASSWORD'], "username"=>ENV['PTP_USERNAME']},
                  :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Faraday v0.9.1'}).
             to_return(:status => 200, :body => "", :headers => {})
  end

  describe "Create" do
    Given do
      stub_request(:get, "https://tls.passthepopcorn.me/torrents.php?json=noredirect&searchstr=#{imdb_url}")
          .to_return(:status => 200, :body => File.read('spec/fixtures/ptp/brotherhood_of_war.json'))
    end

    When do
      post movies_path, params, @env
    end

    context "with valid parameters" do
      Given(:imdb_url){'http://www.imdb.com/title/tt0386064/?ref_=fn_al_tt_2'}
      Given(:params){{imdb_url: imdb_url}}

      Given(:expected_movie_release){MovieRelease.last}
      Then{expect(expected_movie_release).to be_present}
    end
  end
end
