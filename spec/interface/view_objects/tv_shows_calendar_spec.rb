require 'spec_helper'

describe ViewObjects::TvShowsCalendar do
  Given!(:credential){create :credential, name: 'trakt'}
  
  subject{described_class.new}

  describe "Initialization" do
    context "with default options" do
      Given do
        stub_request(:get, "https://api-v2launch.trakt.tv/calendars/my/shows/#{Date.today}/7")
          .with(headers: {'Authorization' => "Bearer #{credential.data['access_token']}"})
          .to_return(body: JSON.parse(File.new('spec/fixtures/trakt/calendars/shows.json').read))
      end

      subject{described_class.new}
      
      Then{expect(subject.episodes.size).to eq 11}
    end
  end

  context "with options" do
    Given do
      stub_request(:get, "https://api-v2launch.trakt.tv/calendars/my/shows/#{from_date}/#{days}")
        .with(headers: {'Authorization' => "Bearer #{credential.data['access_token']}"})
        .to_return(body: JSON.parse(File.new('spec/fixtures/trakt/calendars/shows.json').read))
    end

    Given(:from_date){Date.today-1.week}
    Given(:days){30}

    subject{described_class.new(from_date: from_date, days: days)}
    
    Then{expect(subject.episodes.size).to eq 11}
  end
end
