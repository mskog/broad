# if Rails.env.development?
#   require 'webmock'
#   include WebMock::Api
#   WebMock.enable!

#   require Rails.root.join("spec/support/fake_servers/fake_ptp.rb")
#   require Rails.root.join("spec/support/fake_servers/fake_tmdb.rb")
#   require Rails.root.join("spec/support/fake_servers/fake_trakt.rb")
#   require Rails.root.join("spec/support/fake_servers/fake_spoiled.rb")

#   WebMock.allow_net_connect!

#   if ENV['USE_FAKES'] == '1'
#     allowed_hosts = [/trakt.tv/]

#     WebMock.stub_request(:any, /passthepopcorn.me/).to_rack(FakePTP)
#     WebMock.stub_request(:any, /api.themoviedb.org/).to_rack(FakeTmdb)
#     WebMock.stub_request(:any, /api-v2launch.trakt.tv\/calendars/).to_rack(FakeTrakt)
#     WebMock.stub_request(:any, /api-v2launch.trakt.tv/).to_rack(FakeTrakt)
#     WebMock.stub_request(:any, /spoiled.mskog.com/).to_rack(FakeSpoiled)

#     WebMock.disable_net_connect!(allow_localhost: true, allow: allowed_hosts)
#   end
# end
