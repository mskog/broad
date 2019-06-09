require 'spec_helper'

describe "API:V1:MovieDownloads", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env['ACCEPT'] = 'application/json'
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
    end

    context "with an unacceptable release" do
      Given(:params){{query: "tt0369jsdfij610"}}
      Then{expect(response.status).to eq 422}
      And{expect(Movie.count).to eq 0}
    end
  end
end
