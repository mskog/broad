require 'spec_helper'

describe UpdateAllMovieDetailsJob do
  Given!(:movie1){create :movie, waitlist: true}
  Given!(:movie2){create :movie}
  subject{described_class.new}

  Given{expect(FetchMovieDetailsJob).to receive(:perform_later).with(movie1)}
  Given{expect(FetchMovieDetailsJob).to_not receive(:perform_later).with(movie2)}

  When{subject.perform}
  Then{}
end
