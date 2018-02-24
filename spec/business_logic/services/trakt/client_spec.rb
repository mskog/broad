# require 'spec_helper'

# describe Services::Trakt::Client, :nodb do
#   subject{described_class.new}

#   Given!(:stub) do
#     stub_request(:get, "#{described_class::API_URL}/movies").
#       with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'Trakt-Api-Key'=>ENV['TRAKT_APIKEY'], 'Trakt-Api-Version'=>described_class::API_VERSION, 'User-Agent'=>'Faraday v0.9.2'}).
#       to_return(:status => 200, :body => "", :headers => {})
#   end

#   When{subject.get('/movies')}
#   Then{expect(stub).to have_been_requested}
# end
