require 'spec_helper'

describe UpdateAllTvShowDetailsJob do
  Given!(:tv_show_1){create :tv_show}
  Given!(:tv_show_2){create :tv_show}
  subject{described_class.new}

  Given{expect(FetchTvShowDetailsTmdbJob).to receive(:perform_later).with(tv_show_1)}
  Given{expect(FetchTvShowDetailsTmdbJob).to receive(:perform_later).with(tv_show_2)}
  Given{expect(FetchTvShowDetailsTraktJob).to receive(:perform_later).with(tv_show_1)}
  Given{expect(FetchTvShowDetailsTraktJob).to receive(:perform_later).with(tv_show_2)}

  When{subject.perform}
  Then{}
end
