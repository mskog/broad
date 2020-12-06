require "spec_helper"

describe CheckForBetterMovieReleasesJob do
  When{subject.perform}
  Given(:reloaded_movie){movie.reload}

  Given{allow_any_instance_of(Domain::PTP::Movie).to receive(:fetch_new_releases)}

  context "with an unwatched movie with better releases" do
    Given(:download_at){1.week.ago}
    Given(:movie){create :movie, watched: false, download_at: download_at}
    Given!(:downloaded_release){create :movie_release, resolution: "1080p", movie: movie, downloaded: true}
    Given!(:better_release){create :movie_release, resolution: "2160p", movie: movie}
    Then{expect(reloaded_movie.download_at).to be > download_at}
  end

  context "with an unwatched movie with no releases since they are all 4k" do
    Given(:download_at){1.week.ago}
    Given(:movie){create :movie, watched: false, download_at: download_at}
    Given!(:downloaded_release){create :movie_release, resolution: "2160p", movie: movie, downloaded: true}
    Given!(:better_release){create :movie_release, resolution: "2160p", movie: movie}
    Then{expect(reloaded_movie.download_at).to be_within(10.seconds).of(download_at)}
  end

  context "with an unwatched movie with no better releases" do
    Given(:download_at){1.week.ago}
    Given(:movie){create :movie, watched: false, download_at: download_at}
    Given!(:downloaded_release){create :movie_release, resolution: "1080p", movie: movie, downloaded: true}
    Given!(:other_release){create :movie_release, resolution: "1080p", movie: movie}
    Then{expect(reloaded_movie.download_at).to be_within(10.seconds).of(download_at)}
  end

  context "with a watched movie with better releases" do
    Given(:download_at){1.week.ago}
    Given(:movie){create :movie, watched: true, download_at: download_at}
    Given!(:downloaded_release){create :movie_release, resolution: "1080p", movie: movie, downloaded: true}
    Given!(:better_release){create :movie_release, resolution: "2160p", movie: movie}
    Then{expect(reloaded_movie.download_at).to be_within(10.seconds).of(download_at)}
  end

  context "with a movie which has not been downloaded" do
    Given(:movie){create :movie}
    Given!(:better_release){create :movie_release, resolution: "2160p", movie: movie}
    Then{expect(reloaded_movie.download_at).to_not be_present}
  end

  context "with an unwatched movie with better releases. Movie downloaded more than 1 month ago" do
    Given(:download_at){2.months.ago}
    Given(:movie){create :movie, watched: false, download_at: download_at}
    Given!(:downloaded_release){create :movie_release, resolution: "1080p", movie: movie, downloaded: true}
    Given!(:better_release){create :movie_release, resolution: "2160p", movie: movie}
    Then{expect(reloaded_movie.download_at).to be_within(10.seconds).of(download_at)}
  end
end
