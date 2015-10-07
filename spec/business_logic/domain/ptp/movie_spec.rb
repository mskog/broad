require 'spec_helper'

describe Domain::PTP::Movie do
  Given(:movie){PTPFixturesHelper.build_stubbed(movie_fixture)}
  subject{described_class.new(movie)}

  describe "#best_release" do
    When(:result){subject.best_release}

    context "with a simple movie" do
      Given(:movie_fixture){'jurassic_world'}
      Then{expect(result.ptp_movie_id).to eq 383084}
    end

    context "with a movie with a release with no seeders" do
      Given(:movie_fixture){'jurassic_world_no_seeders'}
      Then{expect(result.ptp_movie_id).to eq 383170}
    end

    context "with a movie with a release with an m2ts container" do
      Given(:movie_fixture){'brotherhood_of_war'}
      Then{expect(result.ptp_movie_id).to eq 136183}
      And{expect(result.download_url).to eq "http://passthepopcorn.me/torrents.php?action=download&id=136183&authkey=&torrent_pass=#{ENV['PTP_PASSKEY']}"}
    end

    context "with a movie with a 3d release" do
      Given(:movie_fixture){'up'}
      Then{expect(result.ptp_movie_id).to eq 98064}
    end

    context "with a movie with a remux" do
      Given(:movie_fixture){'lincoln_lawyer'}
      Then{expect(result.ptp_movie_id).to eq 298502}
    end
  end

  describe "#set_attributes" do
    Given(:movie){build_stubbed :movie}
    Given(:ptp_movie){OpenStruct.new(title: 'The Matrix', imdb_id: 12345)}
    When{subject.set_attributes(ptp_movie)}
    Then{expect(subject.title).to eq ptp_movie.title}
    And{expect(subject.imdb_id).to eq "tt#{ptp_movie.imdb_id}"}
  end

  describe "#fetch_new_releases" do
    Given do
      stub_request(:post, "https://tls.passthepopcorn.me/ajax.php?action=login").
               with(:body => {"passkey"=>ENV['PTP_PASSKEY'], "password"=>ENV['PTP_PASSWORD'], "username"=>ENV['PTP_USERNAME']},
                    :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Faraday v0.9.1'}).
               to_return(:status => 200, :body => "", :headers => {})
    end

    Given(:movie){build_stubbed :movie}
    Given(:ptp_api){Services::PTP::Api.new}
    Given(:ptp_movie){ptp_api.search(movie.imdb_id).movie}
    When{subject.fetch_new_releases(ptp_movie)}

    context "when the movie currently has no releaes" do
      Given do
        stub_request(:get, "https://tls.passthepopcorn.me/torrents.php?json=noredirect&searchstr=#{movie.imdb_id}")
            .to_return(:status => 200, :body => File.read('spec/fixtures/ptp/brotherhood_of_war.json'))
      end

      Then{expect(movie.movie_releases.size).to eq 7}
    end
  end
end
