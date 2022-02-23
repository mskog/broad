require "spec_helper"

describe Domain::Ptp::Movie, :nodb do
  class AcceptsAnyRelease
    def initialize(release)
      @release = release
    end

    def acceptable?
      true
    end
  end

  Given(:movie){PtpFixturesHelper.build_stubbed(movie_fixture)}
  subject{described_class.new(movie)}

  describe "#download" do
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

  describe "#has_better_release_than_downloaded?" do
    Given(:movie){build :movie, releases: releases}
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

    context "with a set rule_klass" do
      subject{described_class.new(movie, acceptable_release_rule_klass: AcceptsAnyRelease)}

      When(:result){subject.has_acceptable_release?}

      Given(:movie_fixture){"tt3659388"}
      Then{expect(result).to be_truthy}
    end
  end

  describe "#has_killer_release?" do
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
        subject{described_class.new(movie, acceptable_release_rule_klass: AcceptsAnyRelease)}

        When(:result){subject.best_release}

        Given(:movie_fixture){"tt3659388"}
        Then{expect(result.ptp_movie_id).to eq 385_539}
      end
    end
  end

  describe "#fetch_new_releases" do
    Given(:releases){[]}
    Given(:movie){build :movie, imdb_id: "tt0386064", releases: releases}
    When{subject.fetch_new_releases}

    context "when the movie currently has no releases" do
      Then{expect(movie.releases.size).to eq 7}
    end

    context "when the movie has some of the releases already and they should be updated" do
      Given(:releases){[build(:movie_release, ptp_movie_id: 18_297, leechers: 29)]}
      Then{expect(movie.releases.size).to eq 7}
      And{expect(releases.first.leechers).to eq 1}
    end

    context "with a release that is no longer available" do
      Given(:releases){[build(:movie_release, ptp_movie_id: 39_893, leechers: 29)]}
      Then{expect(movie.releases.size).to eq 7}
      And{expect(movie.releases).not_to include(releases.first)}
    end
  end
end
