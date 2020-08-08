require "spec_helper"

describe "News", type: :request do
  context "TV Shows" do
    Given(:query) do
      <<-GRAPHQL
      {
        news(category: "tv_shows") {
          title
        }
      }
      GRAPHQL
    end

    Given(:tv_show){create :tv_show}
    Given!(:news_item){create :news_item, category: "tv_shows"}
    Given{create :news_item, category: "tv_shows", newsworthy: tv_show}
    Given{create :news_item, category: "movies"}

    When do
      post graphql_path, env: @env, params: {query: query}
    end

    Given(:parsed_response){JSON.parse(@response.body)}

    Then{expect(parsed_response["data"]["news"].count).to eq 1}
    And{expect(parsed_response["data"]["news"].first["title"]).to eq news_item.title}
  end

  context "Our TV Shows" do
    Given(:query) do
      <<-GRAPHQL
      {
        news(category: "our_tv_shows") {
          title
        }
      }
      GRAPHQL
    end

    Given(:tv_show){create :tv_show}
    Given!(:news_item){create :news_item, category: "tv_shows"}
    Given!(:our_news_item){create :news_item, category: "tv_shows", newsworthy: tv_show}
    Given{create :news_item, category: "movies"}

    When do
      post graphql_path, env: @env, params: {query: query}
    end

    Given(:parsed_response){JSON.parse(@response.body)}

    context "Default" do
      Then{expect(parsed_response["data"]["news"].count).to eq 1}
      And{expect(parsed_response["data"]["news"].first["title"]).to eq our_news_item.title}
    end
  end

  context "Movies" do
    Given(:query) do
      <<-GRAPHQL
      {
        news(category: "movies") {
          title
        }
      }
      GRAPHQL
    end

    Given{create :news_item, category: "tv_shows"}
    Given!(:other_news_item){create :news_item, category: "movies"}

    When do
      post graphql_path, env: @env, params: {query: query}
    end

    Given(:parsed_response){JSON.parse(@response.body)}

    context "Default" do
      Then{expect(parsed_response["data"]["news"].count).to eq 1}
      And{expect(parsed_response["data"]["news"].first["title"]).to eq other_news_item.title}
    end
  end
end
