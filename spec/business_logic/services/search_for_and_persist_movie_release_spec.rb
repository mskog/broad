require 'spec_helper'

describe Services::SearchForAndPersistMovieRelease do
  subject{described_class.new(imdb_id)}

  Given do
    stub_request(:post, "https://tls.passthepopcorn.me/ajax.php?action=login").
             with(:body => {"passkey"=>ENV['PTP_PASSKEY'], "password"=>ENV['PTP_PASSWORD'], "username"=>ENV['PTP_USERNAME']})
             .to_return(:status => 200, :body => "", :headers => {})
  end

  describe "#perform" do
    When{subject.perform}

    context "with results(brotherhood of war)" do
      Given(:imdb_id){'tt0386064'}

      Given do
        stub_request(:get, "https://tls.passthepopcorn.me/torrents.php?json=noredirect&searchstr=#{imdb_id}")
            .to_return(:status => 200, :body => File.read('spec/fixtures/ptp/brotherhood_of_war.json'))
      end

      Given(:movie){Movie.first}
      Given(:releases){movie.releases}
      Given(:first_release){releases.first}

      Then{expect(movie.title).to eq 'Taegukgi hwinalrimyeo AKA Tae Guk Gi: The Brotherhood of War'}
      And{expect(movie.imdb_id).to eq 'tt0386064'}
      And{expect(releases.count).to eq 7}
      And{expect(first_release.ptp_movie_id).to eq 18297}
      And{expect(first_release.auth_key).to eq 'sdfdsfsdf'}
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
      And{expect(first_release.remaster_title).to eq "foo / bar"}
      And{expect(first_release.version_attributes).to contain_exactly('foo', 'bar')}
    end

    context "with no results" do
      Given(:imdb_id){'tt0386064'}

      Given do
        stub_request(:get, "https://tls.passthepopcorn.me/torrents.php?json=noredirect&searchstr=#{imdb_id}")
            .to_return(:status => 200, :body => File.read('spec/fixtures/ptp/noresults.json'))
      end
      Then{expect(Movie.count).to eq 0}
      And{expect(MovieRelease.count).to eq 0}
    end
  end
end
