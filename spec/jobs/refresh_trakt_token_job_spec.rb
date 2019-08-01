require "spec_helper"

describe RefreshTraktTokenJob do
  subject{described_class.new}

  Given(:credential){create :credential}

  Given!(:stub) do
    stub_request(:post, "https://api-v2launch.trakt.tv/oauth/token")
      .with(body: {refresh_token: credential.data["refresh_token"], grant_type: "refresh_token"}.to_json).to_return(body: File.new("spec/fixtures/trakt/refresh_token.json").read)
  end

  When{subject.perform}
  Given(:reloaded_credential){credential.reload}
  Then{expect(stub).to have_been_requested}
  And{expect(reloaded_credential.data).to include("access_token" => "the_access_token", "refresh_token" => "the_refresh_token")}
end
