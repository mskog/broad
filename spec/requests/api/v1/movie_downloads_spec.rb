require "spec_helper"

describe "API:V1:MovieDownloads", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env["ACCEPT"] = "application/json"
  end

  describe "Index" do
    When do
      post api_v1_movie_downloads_path, env: @env, params: params
    end

    context "with an acceptable release" do
      Given(:params){{query: "tt0369610"}}
      Then{expect(response.status).to eq 200}
      And{expect(Movie.count).to eq 1}
      And{expect(Movie.first.releases.count).to_not be_zero}
      And{expect(Movie.first.download_at).to be_between(Date.yesterday, Date.tomorrow).inclusive}
    end

    context "with an acceptable release for a movie which already exists in the database" do
      Given(:query){"tt0369610"}
      Given!(:existing_movie){create :movie, imdb_id: query}
      Given(:params){{query: query}}

      Given(:reloaded_movie){existing_movie.reload}
      Then{expect(response.status).to eq 200}
      And{expect(Movie.first.releases.count).to_not be_zero}
      And{expect(Movie.first.download_at).to be_between(Date.yesterday, Date.tomorrow).inclusive}
    end

    context "with an unacceptable release" do
      Given(:params){{query: "tt0369jsdfij610"}}
      Then{expect(response.status).to eq 422}
      And{expect(Movie.count).to eq 0}
    end
  end
end
