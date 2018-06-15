require 'spec_helper'

describe CollectTvShowJob do
  Given(:mock_domain_object){instance_double(Domain::BTN::TvShow)}
  Given(:tv_show){create :tv_show}

  Given do
    expect(Domain::BTN::TvShow).to receive(:new).with(tv_show){mock_domain_object}
    expect(mock_domain_object).to receive(:collect)
  end

  When{subject.perform(tv_show)}
  Then{}
end
