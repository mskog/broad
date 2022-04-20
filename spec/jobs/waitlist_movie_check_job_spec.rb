require "spec_helper"

describe WaitlistMovieCheckJob, type: :job do
  subject{described_class.new}

  Given!(:movie_waitlist){create :movie, waitlist: true}

  Given(:mock_service){double}
  Given(:mock_api){double}

  Given do
    expect(Services::WaitlistMoviesCheck).to receive(:new).with(movie_waitlist){mock_service}
    expect(mock_service).to receive(:perform)
  end

  When{subject.perform(movie_waitlist)}
  Then {}
end
