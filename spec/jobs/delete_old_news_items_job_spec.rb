require "spec_helper"

describe DeleteOldNewsItemsJob do
  Given!(:news_item_to_delete){create :news_item, created_at: 2.years.ago}
  Given!(:news_item_to_keep){create :news_item, created_at: 10.days.ago}

  When{described_class.perform_now}
  Then{expect(NewsItem.count).to eq 1}
  And{expect(news_item_to_keep.reload).to be_present}
  And{expect(NewsItem.find_by_id(news_item_to_delete.id)).to be_nil}
end
