require "spec_helper"

describe Services::Ptp::Client, :nodb do
  subject{described_class.new}

  Given!(:login_stub) do
    stub_request(:post, "https://passthepopcorn.me/ajax.php?action=login")
      .with(:body => {"passkey" => ENV["Ptp_PASSKEY"], "password" => ENV["Ptp_PASSWORD"], "username" => ENV["Ptp_USERNAME"], keeplogged: "true"})
      .to_return(:status => 200, :body => "", :headers => {})
  end

  When{subject.get("/torrents.php")}
  Then{expect(login_stub).to have_been_requested}
end
