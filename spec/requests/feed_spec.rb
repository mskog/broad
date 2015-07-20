require 'spec_helper'

describe "Feedindex", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env['ACCEPT'] = 'application/rss+xml'
  end

  When do
    get feed_index_path, {}, @env
  end

  Given(:feed_response){Feedjira::Feed.parse_with Feedjira::Parser::RSS, response.body}

  context "with a single item" do
    Given!(:episode){create :episode, published_at: 6.months.ago}
    Given!(:release){create :release, episode: episode}

    Then{expect(feed_response.entries.last.title).to eq release.title}
  end
end
