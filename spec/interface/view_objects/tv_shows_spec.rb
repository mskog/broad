require "spec_helper"

describe ViewObjects::TvShows do
  subject{described_class.new(tv_shows)}

  describe ".from_params" do
    Given!(:tv_shows){[create(:tv_show), create(:tv_show)]}
    When(:result){described_class.from_params(nil)}
    Then{expect(result.map(&:id)).to eq tv_shows.map(&:id)}
  end

  describe "Enumeration", :nodb do
    Given(:tv_shows){[build_stubbed(:tv_show), build_stubbed(:tv_show)]}
    When(:result){subject.to_a}
    Then{expect(result).to eq tv_shows}
    And{expect(result.map(&:id)).to eq tv_shows.map(&:id)}
  end
end
