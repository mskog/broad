require 'spec_helper'

describe Services::OverwatchMoviesCheck do
  subject{described_class.new(movie)}

  describe "#perform" do
    When{subject.perform}

    context "with an acceptable release after fetching" do
      Given(:movie){create :movie, overwatch: true}
      Given(:reloaded_movie){movie.reload}

      Then{expect(movie.reload.releases.size).to eq 7}
      And{expect(reloaded_movie.download_at).to be > DateTime.now-1.hour+ENV['PTP_OVERWATCH_DELAY_HOURS'].to_i.hours}
    end

    context "with no acceptable release after fetching" do
      Given(:movie){create :movie, imdb_id: 'tt1355683', overwatch: true}
      Given(:reloaded_movie){movie.reload}

      Then{expect(movie.reload.releases.size).to eq 0}
      And{expect(reloaded_movie.download_at).to be_nil}
    end

    context "with no releases after fetching" do
      Given!(:movie){create :movie, imdb_id: "2323232323", overwatch: true}
      Given(:reloaded_movie){movie.reload}

      Then{expect(reloaded_movie.releases.size).to eq 0}
      And{expect(reloaded_movie.download_at).to be_nil}
    end
  end
end
