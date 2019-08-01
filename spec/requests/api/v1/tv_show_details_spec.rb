require "spec_helper"

describe "API:V1:TvShowDetails", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env["ACCEPT"] = "application/json"
  end

  describe "Show" do
    When do
      get api_v1_tv_show_detail_path(id), env: @env
    end

    context "with an existing show" do
      Given(:id){"tt2654620"}
      Given(:parsed_response){JSON.parse(response.body)}

      Then{expect(response.status).to eq 200}
      And{expect(parsed_response["title"]).to eq "The Strain"}
    end
  end
end
