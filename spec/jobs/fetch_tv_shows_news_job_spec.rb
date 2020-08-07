require "spec_helper"

describe FetchTvShowsNewsJob do
  Given!(:tv_show){create :tv_show, name: "Better Call Saul"}

  Given do
    stub_request(:get, %r{reddit.com/search.json})
      .to_return(body: File.new("spec/fixtures/reddit/search/tv_shows/better_call_saul.json"))
  end

  When{described_class.perform_now}
  Given(:first_news_item){tv_show.news_items.first}

  Then{expect(tv_show.news_items.count).to eq 2}
  And{expect(first_news_item.title).to eq "Bryan Cranston on Returning as Walt for ‘Better Call Saul’: “I’d Do It in a Second”"}
  And{expect(first_news_item.url).to eq "https://collider.com/better-call-saul-walt-cameo-bryan-cranston-interview/"}
  And{expect(first_news_item.score).to eq 28_789}
end
