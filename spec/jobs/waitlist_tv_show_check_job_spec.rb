require "spec_helper"

describe WaitlistTvShowCheckJob, type: :job do
  subject{described_class.new}

  Given(:tv_show){create :tv_show, tvdb_id: 273_181, waitlist: true}

  When{subject.perform(tv_show)}
  Given{tv_show.reload}

  Then{expect(tv_show.waitlist).to be_falsy}
  And{expect(tv_show.episodes.count).to eq 1}
  And{expect(tv_show.episodes.all{|episode| episode.season == 1}).to be_truthy}
  And{expect(tv_show.episodes.all{|episode| episode.episode == 1}).to be_truthy}
  And{expect(tv_show.waitlist).to be_falsy}
end
