require 'spec_helper'

describe Services::SyncWatchedMoviesWithTrakt do
  Given!(:credential){create :credential, name: 'trakt'}

  subject{described_class.new}

  describe "#perform" do
    Given!(:movie){create :movie, imdb_id: 'tt1700841'}
    Given!(:movie_other){create :movie, imdb_id: 'tt1700842'}

    When{subject.perform}

    Given(:reloaded_movie){movie.reload}

    Then{expect(reloaded_movie.watched?).to be_truthy}
    And{expect(reloaded_movie.watched_at.to_s).to eq "2016-11-05 22:59:08 UTC"}
    And{expect(movie_other.reload.watched?).to be_falsy}
  end
end
