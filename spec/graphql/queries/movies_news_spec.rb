require "spec_helper"

describe "Movies news spec", type: :request do
  Given(:query) do
    <<-GRAPHQL
      {
        moviesNews {
          title
        }
      }
    GRAPHQL
  end

  Given(:tv_show){create :tv_show}
  Given!(:news_item){create :news_item, newsworthy: tv_show}
  Given!(:other_news_item){create :news_item}

  When do
    post graphql_path, env: @env, params: {query: query}
  end

  Given(:parsed_response){JSON.parse(@response.body)}

  context "Default" do
    Then{expect(parsed_response["data"]["moviesNews"].count).to eq 1}
    And{expect(parsed_response["data"]["moviesNews"].first["title"]).to eq other_news_item.title}
  end
end
