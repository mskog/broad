require "spec_helper"

describe Services::Trakt::Token do
  subject{described_class.new}

  describe "#exchange" do
    Given do
      stub_request(:post, "https://api-v2launch.trakt.tv/oauth/token")
        .with(body: {code: auth_code, grant_type: "authorization_code", client_id: ENV["TRAKT_APIKEY"], client_secret: ENV["TRAKT_APISECRET"], redirect_uri: ENV["TRAKT_REDIRECT_URI"]}.to_json)
        .to_return(body: File.new("spec/fixtures/trakt/refresh_token.json").read)
    end

    Given(:auth_code){"sdfsdf"}
    When(:result){subject.exchange(auth_code)}
    Then{expect(result["access_token"]).to eq "the_access_token"}
    And{expect(result["refresh_token"]).to eq "the_refresh_token"}
  end

  describe "#refresh" do
    Given do
      stub_request(:post, "https://api-v2launch.trakt.tv/oauth/token")
        .with(body: {client_id: ENV["TRAKT_APIKEY"], client_secret: ENV["TRAKT_APISECRET"], redirect_uri: ENV["TRAKT_REDIRECT_URI"], refresh_token: refresh_token, grant_type: "refresh_token"}.to_json).to_return(body: File.new("spec/fixtures/trakt/refresh_token.json").read)
    end

    Given(:refresh_token){"sdfsdf"}
    When(:result){subject.refresh(refresh_token)}
    Then{expect(result["access_token"]).to eq "the_access_token"}
    And{expect(result["refresh_token"]).to eq "the_refresh_token"}
  end
end
