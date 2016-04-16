if Rails.env.development? && ENV['USE_FAKES'] == '1'
  require 'webmock'
  include WebMock::Api

  allowed_hosts = [/trakt.tv/]
  allowed_hosts << ENV['DOCKER_IP']

  require Rails.root.join("spec/support/fake_servers/fake_omdb.rb")
  require Rails.root.join("spec/support/fake_servers/fake_ptp.rb")
  require Rails.root.join("spec/support/fake_servers/fake_tmdb.rb")
  # require Rails.root.join("spec/support/fake_servers/fake_trakt.rb")

  WebMock.stub_request(:any, /www.omdbapi.com/).to_rack(FakeOmdb)
  WebMock.stub_request(:any, /tls.passthepopcorn.me/).to_rack(FakePTP)
  WebMock.stub_request(:any, /api.themoviedb.org/).to_rack(FakeTmdb)
  # WebMock.stub_request(:any, /api-v2launch.trakt.tv/).to_rack(FakeTrakt)

  WebMock.disable_net_connect!(allow_localhost: true, allow: allowed_hosts)
end
