require "spec_helper"

describe Movie do
  it_behaves_like "has a valid factory"

  class AcceptsAnyRelease
    def initialize(release)
      @release = release
    end

    def acceptable?
      true
    end
  end

  Given(:reloaded_movie){movie.reload}

  describe ".check_for_better_releases_than_downloaded" do
    Given{allow_any_instance_of(described_class).to receive(:fetch_new_releases)}
    Given{allow(NotifyHuginnJob).to receive(:perform_later)}

    When{described_class.check_for_better_releases_than_downloaded}

    context "with an unwatched movie with better releases" do
      Given(:download_at){1.week.ago}
      Given(:movie){create :movie, watched: false, download_at: download_at}
      Given!(:downloaded_release){create :movie_release, resolution: "1080p", movie: movie, downloaded: true}
      Given!(:better_release){create :movie_release, resolution: "2160p", movie: movie}
      Then{expect(reloaded_movie.download_at).to be > download_at}
      And{expect(NotifyHuginnJob).to have_received(:perform_later).with("A better release for #{movie.title} has been found and will be downloaded.")}
    end

    context "with an unwatched movie with better release by source" do
      Given(:download_at){1.week.ago}
      Given(:movie){create :movie, watched: false, download_at: download_at}
      Given!(:downloaded_release){create :movie_release, resolution: "1080p", source: "web", movie: movie, downloaded: true}
      Given!(:better_release){create :movie_release, resolution: "1080p", source: "blu-ray", movie: movie}
      Then{expect(reloaded_movie.download_at).to be > download_at}
      And{expect(NotifyHuginnJob).to have_received(:perform_later).with("A better release for #{movie.title} has been found and will be downloaded.")}
    end

    context "with an unwatched movie with better with better source, but original was in 4k on web" do
      Given(:download_at){1.week.ago}
      Given(:movie){create :movie, watched: false, download_at: download_at}
      Given!(:downloaded_release){create :movie_release, resolution: "2160p", source: "web", movie: movie, downloaded: true}
      Given!(:better_release){create :movie_release, resolution: "1080p", source: "blu-ray", movie: movie}
      Then{expect(reloaded_movie.download_at).to be_within(10.seconds).of(download_at)}
      And{expect(NotifyHuginnJob).not_to have_received(:perform_later)}
    end

    context "with an unwatched movie with no releases since they are all 4k" do
      Given(:download_at){1.week.ago}
      Given(:movie){create :movie, watched: false, download_at: download_at}
      Given!(:downloaded_release){create :movie_release, resolution: "2160p", movie: movie, downloaded: true}
      Given!(:better_release){create :movie_release, resolution: "2160p", movie: movie}
      Then{expect(reloaded_movie.download_at).to be_within(10.seconds).of(download_at)}
      And{expect(NotifyHuginnJob).not_to have_received(:perform_later)}
    end

    context "with an unwatched movie with better release since the new one is a bluray" do
      Given(:download_at){1.week.ago}
      Given(:movie){create :movie, watched: false, download_at: download_at}
      Given!(:downloaded_release){create :movie_release, resolution: "2160p", movie: movie, downloaded: true, source: "web"}
      Given!(:better_release){create :movie_release, resolution: "2160p", movie: movie}
      Then{expect(reloaded_movie.download_at).to be > download_at}
      And{expect(NotifyHuginnJob).to have_received(:perform_later).with("A better release for #{movie.title} has been found and will be downloaded.")}
    end

    context "with an unwatched movie with no better releases" do
      Given(:download_at){1.week.ago}
      Given(:movie){create :movie, watched: false, download_at: download_at}
      Given!(:downloaded_release){create :movie_release, resolution: "1080p", movie: movie, downloaded: true}
      Given!(:other_release){create :movie_release, resolution: "1080p", movie: movie}
      Then{expect(reloaded_movie.download_at).to be_within(10.seconds).of(download_at)}
      And{expect(NotifyHuginnJob).not_to have_received(:perform_later)}
    end

    context "with a watched movie with better releases" do
      Given(:download_at){1.week.ago}
      Given(:movie){create :movie, watched: true, download_at: download_at}
      Given!(:downloaded_release){create :movie_release, resolution: "1080p", movie: movie, downloaded: true}
      Given!(:better_release){create :movie_release, resolution: "2160p", movie: movie}
      Then{expect(reloaded_movie.download_at).to be_within(10.seconds).of(download_at)}
      And{expect(NotifyHuginnJob).not_to have_received(:perform_later)}
    end

    context "with a movie which has not been downloaded" do
      Given(:movie){create :movie}
      Given!(:better_release){create :movie_release, resolution: "2160p", movie: movie}
      Then{expect(reloaded_movie.download_at).not_to be_present}
      And{expect(NotifyHuginnJob).not_to have_received(:perform_later)}
    end

    context "with an unwatched movie with better releases. Movie downloaded more than 12 months ago" do
      Given(:download_at){13.months.ago}
      Given(:movie){create :movie, watched: false, download_at: download_at}
      Given!(:downloaded_release){create :movie_release, resolution: "1080p", movie: movie, downloaded: true}
      Given!(:better_release){create :movie_release, resolution: "2160p", movie: movie}
      Then{expect(reloaded_movie.download_at).to be_within(10.seconds).of(download_at)}
      And{expect(NotifyHuginnJob).not_to have_received(:perform_later)}
    end
  end

  describe ".downloadable" do
    Given!(:movie_no_download_at){create :movie, waitlist: false}
    Given!(:movie_earlier_download_at){create :movie, waitlist: false, download_at: Date.yesterday}
    Given!(:movie_later_download_at){create :movie, waitlist: false, download_at: Date.tomorrow}
    Given!(:movie_waitlist){create :movie, waitlist: true}
    Given!(:movie_waitlist_downloadable){create :movie, waitlist: true, download_at: DateTime.now - 1.day}
    When(:result){described_class.downloadable}
    Then{expect(result).to contain_exactly(movie_no_download_at, movie_earlier_download_at, movie_waitlist_downloadable)}
  end

  describe ".on_waitlist" do
    Given!(:movie){create :movie, waitlist: false}
    Given!(:movie_waitlist){create :movie, waitlist: true}
    Given!(:movie_waitlist_not_downloadable){create :movie, waitlist: true, download_at: DateTime.now - 1.day}
    When(:result){described_class.on_waitlist}
    Then{expect(result).to contain_exactly(movie_waitlist)}
  end

  describe ".watched" do
    Given!(:movie){create :movie, watched: true}
    Given!(:movie_waitlist){create :movie}
    When(:result){described_class.watched}
    Then{expect(result).to contain_exactly(movie)}
  end

  describe "#download" do
    subject{PtpFixturesHelper.build_stubbed(movie_fixture)}

    When(:result){subject.download}

    context "with no releases" do
      Given(:movie_fixture){"jurassic_world_no_acceptable"}
      Then{expect(result).to be_nil}
    end

    context "with releases" do
      Given(:movie_fixture){"jurassic_world"}
      Then{expect(result).to eq "http://passthepopcorn.me/torrents.php?action=download&id=383084&authkey=&torrent_pass=passkey"}
      And{expect(MovieRelease.last.downloaded).to be_truthy}
    end
  end

  describe "#fetch_new_releases" do
    Given(:releases){[]}
    subject{build :movie, imdb_id: "tt0386064", releases: releases}

    When{subject.fetch_new_releases}

    context "when the movie currently has no releases" do
      Then{expect(subject.releases.size).to eq 7}
    end

    context "when the movie has some of the releases already and they should be updated" do
      Given(:releases){[build(:movie_release, ptp_movie_id: 18_297, leechers: 29)]}
      Then{expect(subject.releases.size).to eq 7}
      And{expect(releases.first.leechers).to eq 1}
    end

    context "with a release that is no longer available" do
      Given(:releases){[build(:movie_release, ptp_movie_id: 39_893, leechers: 29)]}
      Then{expect(subject.releases.size).to eq 7}
      And{expect(subject.releases).not_to include(releases.first)}
    end
  end

  describe "#has_better_release_than_downloaded?" do
    subject{build :movie, releases: releases}

    Given(:releases){[]}
    When(:result){subject.has_better_release_than_downloaded?}

    context "with no releases" do
      Then{expect(result).to be_falsy}
    end

    context "with no downloaded releases" do
      Given(:releases){[build(:movie_release)]}
      Then{expect(result).to be_truthy}
    end

    context "with only the downloaded release" do
      Given(:releases){[build(:movie_release, downloaded: true)]}
      Then{expect(result).to be_falsy}
    end

    context "with no better releases" do
      Given(:release_downloaded){build :movie_release, resolution: "1080p", downloaded: true}
      Given(:release_2){build :movie_release, resolution: "1080p"}
      Given(:releases){[release_2, release_downloaded]}
      Then{expect(result).to be_falsy}
    end

    context "with a better release" do
      Given(:release_downloaded){build :movie_release, resolution: "1080p", downloaded: true}
      Given(:better_release){build :movie_release, resolution: "2160p"}
      Given(:releases){[better_release, release_downloaded]}
      Then{expect(result).to be_truthy}
    end
  end

  describe "#has_acceptable_release?" do
    subject{PtpFixturesHelper.build_stubbed(movie_fixture)}

    context "with no acceptable releases" do
      When(:result){subject.has_acceptable_release?}
      Given(:movie_fixture){"jurassic_world_no_acceptable"}
      Then{expect(result).to be_falsy}
    end

    context "with acceptable releases" do
      When(:result){subject.has_acceptable_release?}
      Given(:movie_fixture){"jurassic_world"}
      Then{expect(result).to be_truthy}
    end

    context "with a block that removes other acceptable releases" do
      When(:result) do
        subject.has_acceptable_release? do |release|
          release.seeders > 100_000
        end
      end
      Given(:movie_fixture){"jurassic_world"}
      Then{expect(result).to be_falsy}
    end

    context "with a block that removes releases, but still leaves at least one" do
      When(:result) do
        subject.has_acceptable_release? do |release|
          release.seeders > 100
        end
      end
      Given(:movie_fixture){"jurassic_world"}
      Then{expect(result).to be_truthy}
    end
  end

  describe "#has_killer_release?" do
    subject{PtpFixturesHelper.build_stubbed(movie_fixture)}

    context "with no killer releases" do
      When(:result){subject.has_killer_release?}
      Given(:movie_fixture){"brotherhood_of_war"}
      Then{expect(result).to be_falsy}
    end

    context "with a killer release" do
      When(:result){subject.has_killer_release?}
      Given(:movie_fixture){"lincoln_lawyer"}
      Then{expect(result).to be_truthy}
    end
  end

  describe "#best_release" do
    subject{PtpFixturesHelper.build_stubbed(movie_fixture)}

    context "with no block" do
      When(:result){subject.best_release}

      context "with a simple movie" do
        Given(:movie_fixture){"jurassic_world"}
        Then{expect(result.ptp_movie_id).to eq 383_084}
      end

      context "with a movie with a release with no seeders(final sort done by size)" do
        Given(:movie_fixture){"jurassic_world_no_seeders"}
        Then{expect(result.ptp_movie_id).to eq 383_170}
      end

      context "with a movie with a release with an m2ts container" do
        Given(:movie_fixture){"brotherhood_of_war"}
        Then{expect(result.ptp_movie_id).to eq 136_183}
        And{expect(result.download_url).to eq "http://passthepopcorn.me/torrents.php?action=download&id=136183&authkey=&torrent_pass=#{ENV['PTP_PASSKEY']}"}
      end

      context "with a movie with a 3d release" do
        Given(:movie_fixture){"up"}
        Then{expect(result.ptp_movie_id).to eq 98_064}
      end

      context "with a movie with a remux" do
        Given(:movie_fixture){"lincoln_lawyer"}
        Then{expect(result.ptp_movie_id).to eq 298_502}
      end

      context "with a movie with a 4k non-remux release" do
        Given(:movie_fixture){"sadak_2"}
        Then{expect(result.ptp_movie_id).to eq 843_539}
      end

      context "with a movie with a 4k remux release" do
        Given(:movie_fixture){"mad_max_fury_road"}
        Then{expect(result.ptp_movie_id).to eq 516_720}
      end
    end

    context "with a block" do
      context "with a block that removes all acceptable releases" do
        Given(:movie_fixture){"jurassic_world"}

        When(:result) do
          subject.best_release do |release|
            release.seeders > 100_000
          end
        end
        Then{expect(result).to be_nil}
      end

      context "with a block that removes releases, but leaves at least one" do
        Given(:movie_fixture){"jurassic_world"}

        When(:result) do
          subject.best_release do |release|
            release.seeders > 750
          end
        end
        Then{expect(result.resolution).to eq "720p"}
      end

      context "with a set rule klass" do
        When(:result){subject.best_release(rule_klass: AcceptsAnyRelease)}

        Given(:movie_fixture){"tt3659388"}
        Then{expect(result.ptp_movie_id).to eq 385_539}
      end
    end
  end

  describe "#deletable?", :nodb do
    subject{movie}

    context "with a movie on waitlist but no download_at" do
      Given(:movie){build_stubbed(:movie, waitlist: true)}
      Then{expect(subject).to be_deletable}
    end

    context "with a movie on waitlist, with download_at but it is later than now" do
      Given(:movie){build_stubbed(:movie, waitlist: true, download_at: Date.tomorrow)}
      Then{expect(subject).to be_deletable}
    end

    context "with a movie on waitlist, with download_at earlier than now" do
      Given(:movie){build_stubbed(:movie, waitlist: true, download_at: Date.yesterday)}
      Then{expect(subject).not_to be_deletable}
    end

    context "with a movie not on the waitlist and with download_at later than now" do
      Given(:movie){build_stubbed(:movie, waitlist: false, download_at: Date.tomorrow)}
      Then{expect(subject).not_to be_deletable}
    end

    context "with a movie not on the waitlist and with download_at earlier than now" do
      Given(:movie){build_stubbed(:movie, waitlist: false, download_at: DateTime.now)}
      Then{expect(subject).not_to be_deletable}
    end
  end
end
