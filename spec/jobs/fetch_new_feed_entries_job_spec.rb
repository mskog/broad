require 'spec_helper'

describe FetchNewFeedEntriesJob do
  subject{described_class.new}

  Given(:mock_service){double}

  When{subject.perform}

  context "without EpisodeReleases" do
    Given(:time){Time.parse('1970-01-01')}
    Given do
      expect(Services::FetchAndPersistFeedEntries).to receive(:new).with(ENV['BTN_FEED_URL'], time){mock_service}
      expect(mock_service).to receive(:perform)
    end

    Then{}
  end

  context "with EpisodeReleases" do
    Given!(:episode_release){create :episode_release, published_at: Date.yesterday}
    Given do
      expect(Services::FetchAndPersistFeedEntries).to receive(:new).with(ENV['BTN_FEED_URL'], episode_release.published_at){mock_service}
      expect(mock_service).to receive(:perform)
    end

    Then{}
  end
end
