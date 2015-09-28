require 'spec_helper'

describe Services::PTP::Api do
  subject{described_class.new}

  Given do
    stub_request(:post, "https://tls.passthepopcorn.me/ajax.php?action=login").
             with(:body => {"passkey"=>"passkey", "password"=>"password", "username"=>"username"},
                  :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Faraday v0.9.1'}).
             to_return(:status => 200, :body => "", :headers => {})
  end


  describe "#search_by_imdb_url" do
    When(:result){subject.search_by_imdb_url(imdb_url)}
    Given(:imdb_url){"http://www.imdb.com/title/tt0386064/?ref_=fn_al_tt_2"}

    context "with results" do
      Given do
        stub_request(:get, "https://tls.passthepopcorn.me/torrents.php?json=noredirect&searchstr=#{imdb_url}")
            .to_return(:status => 200, :body => File.read('spec/fixtures/ptp/brotherhood_of_war.json'))
      end

      Then{expect(result.movie.title).to eq 'Taegukgi hwinalrimyeo AKA Tae Guk Gi: The Brotherhood of War'}
    end

    context "with no results" do
      Given do
        stub_request(:get, "https://tls.passthepopcorn.me/torrents.php?json=noredirect&searchstr=#{imdb_url}")
            .to_return(:status => 200, :body => File.read('spec/fixtures/ptp/empty_search_response.json'))
      end
      Then{expect(result).to_not be_present}
    end
  end
end
