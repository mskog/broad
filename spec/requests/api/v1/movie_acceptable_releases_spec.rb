require "spec_helper"

describe "API:V1:MovieAcceptableReleases", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env["ACCEPT"] = "application/json"
  end

  describe "show" do
    When do
      get api_v1_movie_acceptable_release_path(imdb_id), env: @env
    end

    context "with a movie with no killer release" do
      Given(:imdb_id){"tt0369610"}
      Given(:parsed_response){JSON.parse(response.body)}

      Then{expect(response.status).to eq 200}
      And{expect(parsed_response["imdb_id"]).to eq imdb_id}
      And{expect(parsed_response["has_killer_release"]).to be_falsy}
      And{expect(parsed_response["has_acceptable_release"]).to be_truthy}
      And{expect(parsed_response["best_release"]["release_name"]).to eq "Jurassic.World.2015.1080p.Bluray.X264 Sparks"}
    end

    context "with a movie with a killer release" do
      Given(:imdb_id){"tt1189340"}
      Given(:parsed_response){JSON.parse(response.body)}

      Then{expect(response.status).to eq 200}
      And{expect(parsed_response["imdb_id"]).to eq imdb_id}
      And{expect(parsed_response["has_killer_release"]).to be_truthy}
      And{expect(parsed_response["has_acceptable_release"]).to be_truthy}
      And{expect(parsed_response["best_release"]["release_name"]).to eq "The.Lincoln.Lawyer.2011.Blu Ray.Remux.1080p.Avc.Dts Hd.Ma7.1 Hdremux"}
    end

    context "with a movie with no acceptable releases" do
      Given(:imdb_id){"tt3659388"}
      Given(:parsed_response){JSON.parse(response.body)}

      Then{expect(response.status).to eq 200}
      And{expect(parsed_response["imdb_id"]).to eq imdb_id}
      And{expect(parsed_response["has_killer_release"]).to be_falsy}
      And{expect(parsed_response["has_acceptable_release"]).to be_falsy}
      And{expect(parsed_response["best_release"]).to be_nil}
    end
  end
end
