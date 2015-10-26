require 'spec_helper'

describe ViewObjects::Dashboard do
  subject{described_class.new}

  describe "#movies_waitlist" do
    Given!(:movie_downloadable){create :movie, download_at: Date.yesterday}
    Given!(:movie_waitlist){create :movie, waitlist: true}
    When(:result){subject.movies_waitlist}
    Then{expect(result).to contain_exactly(movie_waitlist)}
  end

  describe "#episodes_today" do
    Given!(:episode_downloadable_today){create :episode, published_at: (DateTime.now-6.hours)}
    Given!(:episode_not_downloadable_today){create :episode, published_at: DateTime.now}
    Given!(:episode_downloadable_yesterday){create :episode, published_at: Date.yesterday}

    When(:result){subject.episodes_today}
    Then{expect(result.map(&:id)).to eq [episode_downloadable_today.id]}
  end
end
