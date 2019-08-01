require "spec_helper"

describe "TvShowEpisodes#index RSS", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env["ACCEPT"] = "application/rss+xml"
  end

  When do
    get api_v1_tv_show_episodes_path(tv_show.id), env: @env
  end

  context "with episodes ready for download and others" do
    Given(:tv_show){create :tv_show}
    Given(:other_tv_show){create :tv_show}
    Given!(:episodes){create_list :episode, 2, tv_show: tv_show}
    Given{create_list :episode, 2, tv_show: other_tv_show}
    Given(:parsed_response){JSON.parse(response.body)}

    Then{expect(parsed_response.count).to eq 2}
    And{expect(parsed_response.map{ |item| item["episode"]}).to match_array episodes.map(&:episode)}
  end
end
