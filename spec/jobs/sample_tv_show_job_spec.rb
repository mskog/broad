require "spec_helper"

describe SampleTvShowJob do
  Given(:tv_show){create :tv_show}

  Given do
    expect(tv_show).to receive(:sample)
  end

  When{subject.perform(tv_show)}
  Then {}
end
