require 'spec_helper'

describe FetchNewMovieReleasesJob do
  subject{described_class.new}

  describe "#perform" do
    Given(:movie){build_stubbed :movie}
    When{subject.perform(movie)}
    Given(:mock_service){instance_double(Services::FetchNewMovieReleases)}
    Given{expect(Services::FetchNewMovieReleases).to receive(:new).and_return(mock_service)}
    Given{expect(mock_service).to receive(:perform)}
    Then{}
  end
end
