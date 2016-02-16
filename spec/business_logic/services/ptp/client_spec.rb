require 'spec_helper'

describe Services::PTP::Client, :nodb do
  subject{described_class.new}

  Given!(:login_stub) do
    stub_request(:post, "https://tls.passthepopcorn.me/ajax.php?action=login").
             with(:body => {"passkey"=>ENV['PTP_PASSKEY'], "password"=>ENV['PTP_PASSWORD'], "username"=>ENV['PTP_USERNAME'], keeplogged: "true"})
             .to_return(:status => 200, :body => "", :headers => {})
  end

  When{subject.get('/torrents.php')}
  Then{expect(login_stub).to have_been_requested}
end
