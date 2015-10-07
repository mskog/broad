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

  context "with a single item" do
    Given!(:episode){create :episode, published_at: 6.months.ago}
    Given!(:release){create :episode_release, episode: episode}

    Then{expect(feed_response.entries.last.title).to eq "#{episode.name} - S0#{episode.season}E0#{episode.episode}"}
    And{expect(feed_response.entries.last.url).to eq download_episode_url(episode.id, key: episode.key)}
  end
end
