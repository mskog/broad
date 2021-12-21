require "spec_helper"

describe WaitlistMovieCheckJob, type: :job do
  subject{described_class.new}

  Given!(:movie_waitlist){create :movie, waitlist: true}

  Given(:mock_service){double}
  Given(:mock_api){double}

  Given do
    expect(Services::Ptp::Api).to receive(:new){mock_api}
    expect(Services::WaitlistMoviesCheck).to receive(:new).with(movie_waitlist, ptp_api: mock_api){mock_service}
    expect(mock_service).to receive(:perform)
  end

  When{subject.perform(movie_waitlist)}
  Then {}
end
