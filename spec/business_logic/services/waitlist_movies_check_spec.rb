require "spec_helper"

describe Services::WaitlistMoviesCheck do
  subject{described_class.new(movie)}

  describe "#perform" do
    When{subject.perform}

    context "with an acceptable release after fetching" do
      Given(:movie){create :movie, waitlist: true}
      Given(:reloaded_movie){movie.reload}

      Given{expect(NotifyHuginnJob).to receive(:perform_later).with("An acceptable release for #{movie.title} has been found. Will download in #{ENV['PTP_WAITLIST_DELAY_HOURS']} hours")}

      Then{expect(movie.reload.releases.size).to eq 7}
      And{expect(reloaded_movie.download_at).to be > DateTime.now - 1.hour + ENV["PTP_WAITLIST_DELAY_HOURS"].to_i.hours}
    end

    context "with a killer release after fetching" do
      Given(:movie){create :movie, waitlist: true, imdb_id: "tt1189340"}
      Given(:reloaded_movie){movie.reload}

      Given{expect(NotifyHuginnJob).to receive(:perform_later).with("A killer release for #{movie.title} has been found. Will download immediately")}

      Then{expect(movie.reload.releases.size).to eq 9}
      And{expect(reloaded_movie.download_at).to be <= DateTime.now}
    end

    context "with no acceptable release after fetching" do
      Given(:movie){create :movie, imdb_id: "tt1355683", waitlist: true}
      Given(:reloaded_movie){movie.reload}

      Then{expect(movie.reload.releases.size).to eq 1}
      And{expect(reloaded_movie.download_at).to be_nil}
    end

    context "with no releases after fetching" do
      Given!(:movie){create :movie, imdb_id: "2323232323", waitlist: true}
      Given(:reloaded_movie){movie.reload}

      Then{expect(reloaded_movie.releases.size).to eq 0}
      And{expect(reloaded_movie.download_at).to be_nil}
    end

    context "when the movie already has a download_at value" do
      Given!(:movie){create :movie, waitlist: true, download_at: Date.tomorrow}
      Given(:reloaded_movie){movie.reload}

      Given{expect(NotifyHuginnJob).to_not receive(:perform_later)}

      Then{expect(reloaded_movie.releases.size).to eq 7}
      And{expect(reloaded_movie.download_at).to eq movie.download_at}
    end

    context "when the movie already has a download_at value, but we have a killer release" do
      Given!(:movie){create :movie, waitlist: true, download_at: Date.tomorrow, imdb_id: "tt1189340"}
      Given(:reloaded_movie){movie.reload}

      Given{expect(NotifyHuginnJob).to receive(:perform_later).with("A killer release for #{movie.title} has been found. Will download immediately")}

      Then{expect(reloaded_movie.releases.size).to eq 9}
      And{expect(reloaded_movie.download_at).to be <= DateTime.now}
    end

    context "when the movie already has a download_at value, but we have a killer release, buuuut download_at is earlier than now" do
      Given!(:movie){create :movie, waitlist: true, download_at: Date.yesterday, imdb_id: "tt1189340"}
      Given(:reloaded_movie){movie.reload}

      Then{expect(reloaded_movie.releases.size).to eq 9}
      And{expect(reloaded_movie.download_at).to eq Date.yesterday}
    end

    context "with a movie with no title" do
      Given(:movie){create :movie, waitlist: true, imdb_id: "tt1189340", title: nil}
      Given(:reloaded_movie){movie.reload}

      Given{expect(NotifyHuginnJob).to_not receive(:perform_later)}

      Then{expect(movie.reload.releases.size).to eq 9}
      And{expect(reloaded_movie.download_at).to be <= DateTime.now}
    end
  end
end
