require "spec_helper"

describe Services::FetchNewMovieReleases do
  Given(:movie){build :movie, imdb_id: imdb_id}
  subject{described_class.new(movie)}

  describe "#perform" do
    When{subject.perform}

    context "with results(brotherhood of war)" do
      Given(:imdb_id){"tt0386064"}

      Given(:releases){movie.releases}
      Given(:first_release){releases.first}

      Then{expect(releases.count).to eq 7}
      And{expect(first_release.ptp_movie_id).to eq 18_297}
      And{expect(first_release.auth_key).to eq "sdfdsfsdf"}
      And{expect(first_release.checked).to be_truthy}
      And{expect(first_release.codec).to eq "xvid"}
      And{expect(first_release.container).to eq "avi"}
      And{expect(first_release.golden_popcorn).to be_falsy}
      And{expect(first_release.leechers).to eq 1}
      And{expect(first_release.seeders).to eq 8}
      And{expect(first_release.quality).to eq "standard definition"}
      And{expect(first_release.release_name).to eq "taegukgi_disc_2"}
      And{expect(first_release.resolution).to eq "576x256"}
      And{expect(first_release.scene).to be_falsy}
      And{expect(first_release.snatched).to eq 232}
      And{expect(first_release.source).to eq "dvd"}
      And{expect(first_release.size).to eq 1_473_257_365}
      And{expect(first_release.remaster_title).to eq "foo / bar"}
    end

    context "with a movie that already has some of the releases and one which no longer exists" do
      Given(:imdb_id){"tt0386064"}

      Given(:releases){movie.releases}

      Given do
        movie.releases << build(:movie_release, ptp_movie_id: 18_297)
        movie.releases << build(:movie_release, ptp_movie_id: 22_222)
      end

      Then{expect(releases.count).to eq 7}
    end
  end
end
