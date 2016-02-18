require 'spec_helper'

describe ViewObjects::Movies do
  subject{described_class.new(scope)}

  context "with waitlist movies" do
    Given!(:movie_waitlist){create :movie, waitlist: true, releases: [create(:movie_release)], updated_at: Date.yesterday}
    Given!(:movie){create :movie}
    Given(:scope){Movie.on_waitlist}

    Given(:first_result){subject.first}
    Then{expect(subject.count).to eq 1}
    And{expect(first_result.id).to eq movie_waitlist.id}
    And{expect(first_result).to have_acceptable_release}
    And{expect(subject.cache_key).to eq "viewobjects-movies-#{movie.updated_at.to_i}"}
  end

  context "with waitlist movies without acceptable releases" do
    Given!(:movie_waitlist){create :movie, waitlist: true, releases: [create(:movie_release, container: 'avi')], updated_at: Date.yesterday}
    Given{create :movie}
    Given(:scope){Movie.on_waitlist}

    Given(:first_result){subject.first}
    Then{expect(subject.count).to eq 1}
    And{expect(first_result.id).to eq movie_waitlist.id}
    And{expect(first_result).to_not have_acceptable_release}
  end

  context "with downloadable movies" do
    Given!(:movie_downloadable){create :movie, waitlist: false, releases: [create(:movie_release)], updated_at: Date.yesterday}
    Given!(:movie){create :movie, waitlist: true}
    Given(:scope){Movie.downloadable}

    Given(:first_result){subject.first}
    Then{expect(subject.count).to eq 1}
    And{expect(first_result.id).to eq movie_downloadable.id}
    And{expect(first_result).to have_acceptable_release}
    And{expect(subject.cache_key).to eq "viewobjects-movies-#{movie.updated_at.to_i}"}
  end

  context "with download movies without acceptable releases" do
    Given!(:movie){create :movie, waitlist: false, releases: [create(:movie_release, container: 'avi')], updated_at: Date.yesterday}
    Given{create :movie, waitlist: true}
    Given(:scope){Movie.downloadable}

    Given(:first_result){subject.first}
    Then{expect(subject.count).to eq 1}
    And{expect(first_result.id).to eq movie.id}
    And{expect(first_result).to_not have_acceptable_release}
  end

  context "with a given rule klass" do
    subject{described_class.new(scope, acceptable_release_rule_klass: Domain::PTP::ReleaseRules::Killer)}
    Given!(:movie){create :movie, waitlist: false, releases: [create(:movie_release)], updated_at: Date.yesterday}
    Given{create :movie, waitlist: true}
    Given(:scope){Movie.downloadable}

    Given(:first_result){subject.first}
    Then{expect(subject.count).to eq 1}
    And{expect(first_result.id).to eq movie.id}
    And{expect(first_result).to_not have_acceptable_release}
  end

end
