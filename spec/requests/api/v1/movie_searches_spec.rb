require 'spec_helper'

describe "API:V1:MovieSearches", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env['ACCEPT'] = 'application/json'
  end

  describe "Index" do
    When do
      get api_v1_movie_searches_path, params, @env
    end

    context "with a text query" do
      Given(:query){'alien'}
      Given(:params){{query: query}}
      Given(:parsed_response){JSON.parse(response.body)}
      Given(:first_result){parsed_response.first}

      Then{expect(response.status).to eq 200}
      And{expect(parsed_response.count).to eq 9}
      And{expect(first_result['title']).to eq 'Alien'}
      And{expect(first_result['poster']).to eq 'https://walter.trakt.us/images/movies/000/000/295/posters/thumb/b943584d95.jpg'}
    end
  end
end
