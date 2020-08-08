require "spec_helper"

describe FetchTvShowsNewsJob do
  Given!(:tv_show){create :tv_show, watching: true, name: "Better Call Saul"}

  Given do
    stub_request(:get, %r{reddit.com/r/television})
      .to_return(body: File.new("spec/fixtures/reddit/tv_shows.json"))
  end

  Given do
    stub_request(:get, %r{reddit.com/search.json})
      .to_return(body: File.new("spec/fixtures/reddit/search/tv_shows/better_call_saul.json"))
  end

  When{described_class.perform_now}
  Given(:first_news_item){tv_show.news_items.first}

  Then{expect(tv_show.news_items.count).to eq 1}
  And{expect(first_news_item.title).to include "Better Call Saul"}
  And{expect(first_news_item.category).to eq "tv_shows"}
  And{expect(NewsItem.count).to eq 19}
end
