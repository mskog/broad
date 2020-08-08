require "spec_helper"

describe FetchMovieNewsJob do
  Given do
    stub_request(:get, %r{reddit.com/r/movies})
      .to_return(body: File.new("spec/fixtures/reddit/movies.json"))
  end

  When{described_class.perform_now}
  Given(:first_news_item){NewsItem.first}

  Then{expect(NewsItem.count).to eq 5}

  And{expect(first_news_item.title).to eq "‘John Wick 5’ Confirmed By Lionsgate; Sequel Will Be Shot Back To Back With Fourth Installment"}
  And{expect(first_news_item.url).to include "https://deadline.com"}
  And{expect(first_news_item.score).to eq 32_171}
  And{expect(first_news_item.category).to eq "movies"}
end
