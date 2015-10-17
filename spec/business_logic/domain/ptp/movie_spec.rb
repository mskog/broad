require 'spec_helper'

describe Domain::PTP::Movie, :nodb do
  class AcceptsAnyRelease
    def initialize(release)
      @release = release
    end

    def acceptable?
      true
    end
  end


  Given(:movie){PTPFixturesHelper.build_stubbed(movie_fixture)}
  subject{described_class.new(movie)}

  describe "#has_acceptable_release?" do
    context "with no acceptable releases" do
      When(:result){subject.has_acceptable_release?}
      Given(:movie_fixture){'jurassic_world_no_acceptable'}
      Then{expect(result).to be_falsy}
    end

    context "with acceptable releases" do
      When(:result){subject.has_acceptable_release?}
      Given(:movie_fixture){'jurassic_world'}
      Then{expect(result).to be_truthy}
    end

    context "with a block that removes other acceptable releases" do
      When(:result) do
        subject.has_acceptable_release? do |release|
          release.seeders > 100000
        end
      end
      Given(:movie_fixture){'jurassic_world'}
      Then{expect(result).to be_falsy}
    end

    context "with a block that removes releases, but still leaves at least one" do
      When(:result) do
        subject.has_acceptable_release? do |release|
          release.seeders > 100
        end
      end
      Given(:movie_fixture){'jurassic_world'}
      Then{expect(result).to be_truthy}
    end

    context "with a set rule_klass" do
      subject{described_class.new(movie, acceptable_release_rule_klass: AcceptsAnyRelease)}

      When(:result){subject.has_acceptable_release?}

      Given(:movie_fixture){'tt3659388'}
      Then{expect(result).to be_truthy}
    end
  end

  describe "#best_release" do
    context "with no block" do
      When(:result){subject.best_release}

      context "with a simple movie" do
        Given(:movie_fixture){'jurassic_world'}
        Then{expect(result.ptp_movie_id).to eq 383084}
      end

      context "with a movie with a release with no seeders(final sort done by snatches)" do
        Given(:movie_fixture){'jurassic_world_no_seeders'}
        Then{expect(result.ptp_movie_id).to eq 383072}
      end

      context "with a movie with a release with an m2ts container" do
        Given(:movie_fixture){'brotherhood_of_war'}
        Then{expect(result.ptp_movie_id).to eq 136183}
        And{expect(result.download_url).to eq "http://passthepopcorn.me/torrents.php?action=download&id=136183&authkey=&torrent_pass=#{ENV['PTP_PASSKEY']}"}
      end

      context "with a movie with a 3d release" do
        Given(:movie_fixture){'up'}
        Then{expect(result.ptp_movie_id).to eq 128228}
      end

      context "with a movie with a remux" do
        Given(:movie_fixture){'lincoln_lawyer'}
        Then{expect(result.ptp_movie_id).to eq 298502}
      end
    end

    context "with a block" do
      context "with a block that removes all acceptable releases" do
        Given(:movie_fixture){'jurassic_world'}

        When(:result) do
          subject.best_release do |release|
            release.seeders > 100000
          end
        end
        Then{expect(result).to be_nil}
      end

      context "with a block that removes releases, but leaves at least one" do
        Given(:movie_fixture){'jurassic_world'}

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

        Given(:movie_fixture){'tt3659388'}
        Then{expect(result.ptp_movie_id).to eq 385239}
      end
    end
  end

  describe "#fetch_new_releases" do
    Given(:movie){build_stubbed :movie, imdb_id: "tt0386064"}
    When{subject.fetch_new_releases}

    context "when the movie currently has no releases" do
      Then{expect(movie.releases.size).to eq 7}
    end
  end
end
