require 'spec_helper'

describe Movie do
  it{is_expected.to have_many(:releases).class_name(MovieRelease)}

  describe ".downloadable" do
    Given!(:movie){create :movie, overwatch: false}
    Given!(:movie_overwatch){create :movie, overwatch: true}
    When(:result){described_class.downloadable}
    Then{expect(result).to contain_exactly(movie)}
  end

  describe ".on_overwatch" do
    Given!(:movie){create :movie, overwatch: false}
    Given!(:movie_overwatch){create :movie, overwatch: true}
    When(:result){described_class.on_overwatch}
    Then{expect(result).to contain_exactly(movie_overwatch)}
  end
end
