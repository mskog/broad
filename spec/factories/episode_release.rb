FactoryBot.define do
  factory :episode_release do
    title { 'hello' }
    source { 'hdtv' }
    resolution { '1080p' }
    url {Faker::Internet.url}

    after(:stub, :create, :build) do |episode_release, evaluator|
      WebMock.stub_request(:head, episode_release.url).to_return(File.new('spec/fixtures/btn/existing_torrent.txt'))
    end
  end

  factory :episode_release_missing, class: EpisodeRelease do
    title { 'hello' }
    source { 'hdtv' }
    resolution { '1080p' }
    url {Faker::Internet.url}

    after(:stub, :create, :build) do |episode_release, evaluator|
      WebMock.stub_request(:head, episode_release.url).to_return(File.new('spec/fixtures/btn/missing_torrent.txt'))
    end
  end
end
