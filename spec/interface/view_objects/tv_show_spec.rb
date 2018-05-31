require 'spec_helper'

describe ViewObjects::TvShow do
  describe ".from_params" do
    Given(:tv_show){create :tv_show}
    Given(:params){{id: tv_show.id}}
    subject{described_class.from_params(params)}

    Then{expect(subject.id).to eq tv_show.id}
    And{expect(subject).to respond_to :sample }
  end
end
