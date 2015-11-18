require 'spec_helper'

describe NotifyHuginnJob do
  subject{described_class.new}

  Given!(:stub) do
    stub_request(:post, ENV['HUGINN_NOTIFICATIONS_URL'])
      .with(:body => {"message"=> message})
      .to_return(:status => 200)
  end

  Given(:message){'Hello World'}
  When{subject.perform(message)}
  Then{expect(stub).to have_been_requested}
end
