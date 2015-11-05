require 'spec_helper'

describe "API:V1:Movies", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env['ACCEPT'] = 'application/json'
  end

  describe "Create" do
    When do
      post api_v1_movie_waitlists_path, params, @env
    end

    context "with valid parameters" do
      Given(:imdb_id){'tt0386064'}
      Given(:params){{imdb_id: imdb_id}}

      Given(:expected_movie){Movie.last}

      Then{expect(response.status).to eq 200}
      And{expect(expected_movie.imdb_id).to eq 'tt0386064'}
    end

    context "with invalid parameters" do
      Given(:imdb_id){'tt0386064'}
      Given(:params){{dsfdsfsdfsdf: imdb_id}}

      Then{expect(response.status).to eq 400}
    end
  end
end
