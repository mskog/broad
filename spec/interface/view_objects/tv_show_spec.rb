require 'spec_helper'

describe ViewObjects::TvShow do
  subject{described_class.new(tv_show)}

  describe ".from_params" do
    Given(:tv_show){create :tv_show}
    Given(:params){{id: tv_show.id}}
    subject{described_class.from_params(params)}

    Then{expect(subject.id).to eq tv_show.id}
    And{expect(subject).to respond_to :sample }
  end

  describe "#aired_episodes" do
    Given(:tv_show){create :tv_show}
    Given!(:aired_episode){create :episode, :aired, tv_show: tv_show}
    Given{create :episode}

    When(:result){subject.aired_episodes}
    Then{expect(result.map(&:id)).to eq [aired_episode.id]}
  end
end
