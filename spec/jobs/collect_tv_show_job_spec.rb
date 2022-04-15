require "spec_helper"

describe CollectTvShowJob do
  Given(:tv_show){create :tv_show}

  Given do
    expect(tv_show).to receive(:collect)
  end

  When{subject.perform(tv_show)}
  Then {}
end
