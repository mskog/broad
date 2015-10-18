require 'spec_helper'

describe WaitlistMoviesCheckJob, type: :job do
  subject{described_class.new}

  Given!(:movie_waitlist){create :movie, waitlist: true}
  Given!(:movie){create :movie}

  Given(:mock_service){double}
  Given(:mock_api){double}

  Given do
    expect(Services::PTP::Api).to receive(:new){mock_api}
    expect(Services::WaitlistMoviesCheck).to receive(:new).with(movie_waitlist, ptp_api: mock_api){mock_service}
    expect(mock_service).to receive(:perform)
  end

  When{subject.perform}
  Then{}
end
