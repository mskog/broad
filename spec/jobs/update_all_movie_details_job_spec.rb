require "spec_helper"

describe UpdateAllMovieDetailsJob do
  Given!(:movie){create :movie}
  subject{described_class.new}

  Given{expect(FetchMovieDetailsJob).to receive(:perform_later).with(movie)}
  Given{expect(FetchMovieImagesJob).to receive(:perform_later).with(movie)}

  When{subject.perform}
  Then {}
end
