require 'spec_helper'

describe Movie do
  it{is_expected.to have_many(:releases).class_name(MovieRelease)}

  describe ".for_download" do
    Given!(:movie){create :movie, overwatch: false}
    Given!(:movie_overwatch){create :movie, overwatch: true}
    When(:result){described_class.for_download}
    Then{expect(result).to contain_exactly(movie)}
  end
end
