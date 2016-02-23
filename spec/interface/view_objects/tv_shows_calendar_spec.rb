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
      
      Given(:first_episode){subject.episodes.first}
      Then{expect(subject.episodes.count).to eq 11}
      And{expect(first_episode.imdb_id).to be_nil}
      And{expect(first_episode.trakt_id).to eq 1765462}
      And{expect(first_episode.season).to eq 5}
      And{expect(first_episode.number).to eq 18}
      And{expect(first_episode.title).to eq "The Maid of Gévaudan"}
      And{expect(first_episode.first_aired).to eq Date.parse('2016-02-24')}
      And{expect(first_episode.show_title).to eq "Teen Wolf"}

      And{expect(subject.cache_key).to eq "viewobjects-tv_shows_calendar-#{Date.today.to_time.to_i}"}
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
    
    Then{expect(subject.episodes.count).to eq 11}
    And{expect(subject.cache_key).to eq "viewobjects-tv_shows_calendar-#{from_date.to_time.to_i}-#{days}-#{Date.today.to_time.to_i}"}
  end

end
