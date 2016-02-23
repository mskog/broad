require 'spec_helper'

describe ViewObjects::TvShowsCalendar do
  Given!(:credential){create :credential, name: 'trakt'}

  subject{described_class.new}

  describe "Initialization" do
    context "with default options" do
      Given do
        stub_request(:get, "https://api-v2launch.trakt.tv/calendars/my/shows/#{Date.today.at_beginning_of_week}/7")
          .with(headers: {'Authorization' => "Bearer #{credential.data['access_token']}"})
          .to_return(body: JSON.parse(File.new('spec/fixtures/trakt/calendars/shows.json').read))
      end

      subject{described_class.new}

      Given(:first_episode){subject.episodes.first}
      Then{expect(subject.episodes.count).to eq 11}
      And{expect(first_episode.episode.ids.imdb).to be_nil}
      And{expect(first_episode.episode.ids.trakt).to eq 1765462}
      And{expect(first_episode.episode.season).to eq 5}
      And{expect(first_episode.episode.number).to eq 18}
      And{expect(first_episode.episode.title).to eq "The Maid of Gévaudan"}
      And{expect(first_episode.first_aired).to eq DateTime.parse('Wed, 24 Feb 2016 02:00:00.000000000 +0000')}
      And{expect(first_episode.show.title).to eq "Teen Wolf"}

      And{expect(subject.cache_key).to eq "viewobjects-tv_shows_calendar-#{Date.today.at_beginning_of_week.to_time.to_i}"}
      And{expect(subject.by_date[Date.parse('2016-02-24')].count).to eq 3}
      And{expect(subject.by_date[Date.parse('2016-02-24')].first.show.title).to eq 'Teen Wolf'}
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
    And{expect(subject.cache_key).to eq "viewobjects-tv_shows_calendar-#{from_date.to_time.to_i}-#{days}"}
    And{expect(subject.by_date[Date.parse('2016-02-24')].count).to eq 3}
    And{expect(subject.by_date[Date.parse('2016-02-24')].first.show.title).to eq 'Teen Wolf'}
  end

end
