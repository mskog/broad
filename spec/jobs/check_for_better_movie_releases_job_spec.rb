require "spec_helper"

describe CheckForBetterMovieReleasesJob do
  When{subject.perform}

  Given{allow(Movie).to receive(:check_for_better_releases_than_downloaded)}
  Then{expect(Movie).to have_received(:check_for_better_releases_than_downloaded)}
end
