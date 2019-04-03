require 'spec_helper'

describe "API:V1:Movies", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env['ACCEPT'] = 'application/json'
  end

  describe "Index" do
    Given(:params){{}}
    Given!(:movie_waitlist){create :movie, waitlist: true, releases: create_list(:movie_release, 1)}
    Given!(:movie_downloaded){create :movie, waitlist: false, releases: create_list(:movie_release, 1)}
    Given!(:movie_watched){create :movie, watched: true, releases: create_list(:movie_release, 1)}

    When do
      get api_v1_movies_path, env: @env, params: params
    end

    context "with no category" do
      Given(:parsed_response){JSON.parse(response.body)}
      Given(:first_result){parsed_response.first}

      Then{expect(response.status).to eq 200}
      And{expect(parsed_response.count).to eq 3}
    end

    context "with downloaded movies" do
      Given(:params){{category: 'downloads'}}
      Given(:parsed_response){JSON.parse(response.body)}
      Given(:first_result){parsed_response.first}

      Then{expect(response.status).to eq 200}
      And{expect(parsed_response.count).to eq 2}
      And{expect(first_result['title']).to eq movie_downloaded.title}
      And{expect(first_result["best_release"]['release_name']).to eq movie_downloaded.releases.first.release_name.titleize}
    end

    context "with waitlist movies" do
      Given(:params){{category: 'waitlist'}}
      Given(:parsed_response){JSON.parse(response.body)}
      Given(:first_result){parsed_response.first}

      Then{expect(response.status).to eq 200}
      And{expect(parsed_response.count).to eq 1}
      And{expect(first_result['title']).to eq movie_waitlist.title}
      And{expect(first_result["best_release"]['release_name']).to eq movie_waitlist.releases.first.release_name.titleize}
    end

    context "with watched movies" do
      Given(:params){{category: 'watched'}}
      Given(:parsed_response){JSON.parse(response.body)}
      Given(:first_result){parsed_response.first}

      Then{expect(response.status).to eq 200}
      And{expect(parsed_response.count).to eq 1}
      And{expect(first_result['title']).to eq movie_watched.title}
      And{expect(first_result["best_release"]['release_name']).to eq movie_watched.releases.first.release_name.titleize}
    end
  end

  describe "Show" do
    Given(:params){{}}
    Given!(:movie){create :movie, releases: create_list(:movie_release, 1)}

    When do
      get api_v1_movie_path(movie.id), env: @env
    end

    Given(:parsed_response){JSON.parse(response.body)}

    Then{expect(response.status).to eq 200}
    And{expect(parsed_response['title']).to eq movie.title}
    And{expect(parsed_response["best_release"]['release_name']).to eq movie.releases.first.release_name.titleize}
  end
end
