require 'spec_helper'

describe Domain::PTP::Movie do
  subject{described_class.new(PTPFixturesHelper.build_stubbed(movie_fixture))}

  describe "#best_release" do
    When(:result){subject.best_release}

    context "with a simple movie" do
      Given(:movie_fixture){'jurassic_world'}
      Then{expect(result.ptp_movie_id).to eq 383084}
    end

    context "with a movie with a release with no seeders" do
      Given(:movie_fixture){'jurassic_world_no_seeders'}
      Then{expect(result.ptp_movie_id).to eq 383170}
    end

    context "with a movie with a release with an m2ts container" do
      Given(:movie_fixture){'brotherhood_of_war'}
      Then{expect(result.ptp_movie_id).to eq 136183}
    end
  end
end
