require "spec_helper"

describe "Show collection progress", type: :request do
  Given{create :credential}

  Given(:query) do
    <<-GRAPHQL
    {
      showCollectionProgress(id: "tt3032476"){
        airedEpisodes
        completedEpisodes
        completed

        seasons{
          number
          airedEpisodes
          completed
          episodes{
            number
            completed
          }
        }
      }
    }
    GRAPHQL
  end

  When do
    post graphql_path, params: {query: query}
  end

  Given(:parsed_response){JSON.parse(response.body)}

  Then{expect(parsed_response["data"]["showCollectionProgress"]["airedEpisodes"]).to eq 16}
  And{expect(parsed_response["data"]["showCollectionProgress"]["seasons"].count).to eq 2}
  And{expect(parsed_response["data"]["showCollectionProgress"]["seasons"][0]["episodes"].count).to eq 8}
  And{expect(parsed_response["data"]["showCollectionProgress"]["seasons"][0]["episodes"][0]["completed"]).to be_truthy}
end
