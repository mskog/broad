require 'spec_helper'

describe "API:V1:MovieRecommendations", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env['ACCEPT'] = 'application/json'
  end

  describe "Index" do
    Given!(:movie_recommendation){create :movie_recommendation}

    When do
      get api_v1_movie_recommendations_path, env: @env
    end

    Given(:parsed_response){JSON.parse(response.body)}
    Given(:first_result){parsed_response.first}

    Then{expect(response.status).to eq 200}
    And{expect(parsed_response.count).to eq 1}
    And{expect(first_result['title']).to eq movie_recommendation.title}
  end

  describe "Download" do
    Given(:movie_recommendation){create :movie_recommendation}
    Given(:movie){Movie.last}

    When do
      put download_api_v1_movie_recommendation_path(movie_recommendation.id), env: @env
    end

    Then{expect(response.status).to eq 200}
    And{expect(movie.waitlist).to be_truthy}
    And{expect(movie.imdb_id).to eq movie_recommendation.imdb_id}
    # And{expect(CheckWaitlistMovieJob).to have_been_enqueued.with(movie)}
    # And{expect(HideMovieRecommendationJob).to have_been_enqueued.with(movie_recommendation)}
  end

  describe "Destroy" do
    Given(:movie_recommendation){create :movie_recommendation}

    When do
      delete api_v1_movie_recommendation_path(movie_recommendation.id), env: @env
    end

    Then{expect(response.status).to eq 200}
  end
end
