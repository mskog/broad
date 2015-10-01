require 'spec_helper'

describe Services::SearchForAndPersistMovieRelease do
  subject{described_class.new(imdb_url)}

  Given do
    stub_request(:post, "https://tls.passthepopcorn.me/ajax.php?action=login").
             with(:body => {"passkey"=>ENV['PTP_PASSKEY'], "password"=>ENV['PTP_PASSWORD'], "username"=>ENV['PTP_USERNAME']},
                  :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Faraday v0.9.1'}).
             to_return(:status => 200, :body => "", :headers => {})
  end

  describe "#perform" do
    When{subject.perform}

    context "with results" do
      Given(:imdb_url){'http://www.imdb.com/title/tt0386064/?ref_=fn_al_tt_2'}

      Given do
        stub_request(:get, "https://tls.passthepopcorn.me/torrents.php?json=noredirect&searchstr=#{imdb_url}")
            .to_return(:status => 200, :body => File.read('spec/fixtures/ptp/brotherhood_of_war.json'))
      end

      Given(:movie){Movie.first}
      Given(:releases){movie.movie_releases}
      Given(:first_release){releases.first}

      Then{expect(movie.title).to eq 'Taegukgi hwinalrimyeo AKA Tae Guk Gi: The Brotherhood of War'}
      And{expect(releases.count).to eq 7}
      And{expect(first_release.ptp_movie_id).to eq 18297}
      And{expect(first_release.checked).to be_truthy}
      And{expect(first_release.codec).to eq 'xvid'}
      And{expect(first_release.container).to eq 'avi'}
      And{expect(first_release.golden_popcorn).to be_falsy}
      And{expect(first_release.leechers).to eq 1}
      And{expect(first_release.seeders).to eq 8}
      And{expect(first_release.quality).to eq 'standard definition'}
      And{expect(first_release.release_name).to eq 'taegukgi_disc_2'}
      And{expect(first_release.resolution).to eq '576x256'}
      And{expect(first_release.scene).to be_falsy}
      And{expect(first_release.snatched).to eq 232}
      And{expect(first_release.source).to eq "dvd"}
      And{expect(first_release.size).to eq 1473257365}
    end

    context "with no results" do
      Given(:imdb_url){'http://www.imdb.com/title/tt0386064/?ref_=fn_al_tt_2'}

      Given do
        stub_request(:get, "https://tls.passthepopcorn.me/torrents.php?json=noredirect&searchstr=#{imdb_url}")
            .to_return(:status => 200, :body => File.read('spec/fixtures/ptp/noresults.json'))
      end
      Then{expect(MovieRelease.count).to eq 0}
    end
  end
end
