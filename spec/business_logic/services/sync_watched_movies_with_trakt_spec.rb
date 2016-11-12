require 'spec_helper'

describe Services::SyncWatchedMoviesWithTrakt do
  Given!(:credential){create :credential, name: 'trakt'}

  subject{described_class.new}

  describe "#perform" do
    Given!(:movie){create :movie, imdb_id: 'tt1700841'}
    Given!(:movie_other){create :movie, imdb_id: 'tt1700842'}

    When{subject.perform}

    Then{expect(movie.reload.watched?).to be_truthy}
    And{expect(movie_other.reload.watched?).to be_falsy}
  end
end
