require 'spec_helper'

describe "Episodes#index RSS", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env['ACCEPT'] = 'application/rss+xml'
  end

  When do
    get episodes_path, {}, @env
  end

  Given(:feed_response){Feedjira::Feed.parse_with Feedjira::Parser::RSS, response.body}

  context "with episodes ready for download and others" do
    Given!(:downloadable_episode){create :episode, published_at: 6.months.ago}
    Given!(:release){create :episode_release, episode: downloadable_episode}
    Given!(:other_episode){create :episode, published_at: Date.tomorrow}
    Given!(:other_release){create :episode_release, episode: other_episode}

    Then{expect(feed_response.entries.last.title).to eq "#{downloadable_episode.name} - S0#{downloadable_episode.season}E0#{downloadable_episode.episode}"}
    And{expect(feed_response.entries.last.url).to eq download_episode_url(downloadable_episode.id, key: downloadable_episode.key)}
    And{expect(feed_response.entries.count).to eq 1}
  end
end
