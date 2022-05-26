require "spec_helper"

describe FetchMovieReleaseDatesJob do
  Given(:movie){create :movie}
  When{described_class.perform_now movie}

  Then{expect(movie.release_dates.count).to eq 2}
end
