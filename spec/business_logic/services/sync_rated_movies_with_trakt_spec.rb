require 'spec_helper'

describe Services::SyncRatedMoviesWithTrakt do
  Given!(:credential){create :credential, name: 'trakt'}

  subject{described_class.new}

  describe "#perform" do
    Given!(:movie){create :movie, imdb_id: 'tt5649144'}
    Given!(:movie_other){create :movie, imdb_id: 'tt1700842'}

    When{subject.perform}

    Given(:reloaded_movie){movie.reload}

    Then{expect(reloaded_movie.personal_rating).to eq 8}
  end
end
