require "spec_helper"

describe "Show collection progress", type: :request do
  include GraphQL::TestHelpers
  Given{create :credential}

  Given(:tv_show){create :tv_show, imdb_id: "tt0120737"}

  Given(:gql) do
    <<-GRAPHQL
      query showCollectionProgress($id: ID!){
        showCollectionProgress(id: $id){
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

  When(:result) do
    query(gql, variables: {id: tv_show.id})
  end

  Then{expect(result.errors).to be_nil}
  And{expect(result.data["showCollectionProgress"]["airedEpisodes"]).to eq 16}
  And{expect(result.data["showCollectionProgress"]["seasons"].count).to eq 2}
  And{expect(result.data["showCollectionProgress"]["seasons"][0]["episodes"].count).to eq 8}
  And{expect(result.data["showCollectionProgress"]["seasons"][0]["episodes"][0]["completed"]).to be_truthy}
end
