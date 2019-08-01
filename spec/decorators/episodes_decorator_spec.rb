require "spec_helper"

describe EpisodesDecorator do
  subject{described_class.new(episodes)}

  describe "grouped_by_published_date" do
    Given(:episode_today_1){build_stubbed :episode, published_at: Date.today}
    Given(:episode_today_2){build_stubbed :episode, published_at: Date.today}
    Given(:episode_yesterday){build_stubbed :episode, published_at: Date.yesterday}
    Given(:episodes){[episode_today_1, episode_today_2, episode_yesterday]}
    When(:result){subject.grouped_by_published_date}
    Then{expect(result[Date.today]).to eq [episode_today_1, episode_today_2]}
    And{expect(result[Date.yesterday]).to eq [episode_yesterday]}
  end

  describe "grouped_by_created_date" do
    Given(:episode_today_1){build_stubbed :episode, created_at: Date.today}
    Given(:episode_today_2){build_stubbed :episode, created_at: Date.today}
    Given(:episode_yesterday){build_stubbed :episode, created_at: Date.yesterday}
    Given(:episodes){[episode_today_1, episode_today_2, episode_yesterday]}
    When(:result){subject.grouped_by_created_date}
    Then{expect(result[Date.today]).to eq [episode_today_1, episode_today_2]}
    And{expect(result[Date.yesterday]).to eq [episode_yesterday]}
  end
end
