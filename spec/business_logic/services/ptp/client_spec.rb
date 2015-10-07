require 'spec_helper'

describe Services::PTP::Client do
  subject{described_class.new}

  Given!(:login_stub) do
    stub_request(:post, "https://tls.passthepopcorn.me/ajax.php?action=login").
             with(:body => {"passkey"=>ENV['PTP_PASSKEY'], "password"=>ENV['PTP_PASSWORD'], "username"=>ENV['PTP_USERNAME']})
             .to_return(:status => 200, :body => "", :headers => {})
  end

  When{subject}
  Then{expect(login_stub).to have_been_requested}
end
