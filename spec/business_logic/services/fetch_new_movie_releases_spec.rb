require 'spec_helper'

describe Services::FetchNewMovieReleases do
  Given(:movie){build :movie, imdb_id: imdb_id}
  subject{described_class.new(movie)}

  describe "#perform" do
    When{subject.perform}

    context "with results(brotherhood of war)" do
      Given(:imdb_id){'tt0386064'}

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

    context "with a movie that already has some of the releases" do
      Given(:imdb_id){'tt0386064'}

      Given(:releases){movie.releases}

      Given do
        movie.releases << build(:movie_release, ptp_movie_id: 18297)
        movie.releases << build(:movie_release, ptp_movie_id: 18292)
      end

      Then{expect(releases.count).to eq 8}
    end

    context "with no results" do
      Given(:imdb_id){'sdfdsf'}

      Then{expect(Movie.count).to eq 0}
      And{expect(MovieRelease.count).to eq 0}
    end
  end
end
