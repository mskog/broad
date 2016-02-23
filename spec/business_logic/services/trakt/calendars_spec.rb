require 'spec_helper'

describe Services::Trakt::Calendars do
  Given(:token){'some_token'}

  subject{described_class.new(token: token)}

  describe "#shows" do
    context "with defaults" do
      Given do
        stub_request(:get, "https://api-v2launch.trakt.tv/calendars/my/shows/#{Date.today}/7")
          .with(headers: {'Authorization' => "Bearer #{token}"})
          .to_return(body: JSON.parse(File.new('spec/fixtures/trakt/calendars/shows.json').read))
      end

      Given(:first_result){result.first}
      When(:result){subject.shows}
      Then{expect(result.size).to eq 11}
      And{expect(first_result['episode']['ids']['tvdb']).to eq 5479986}
      And{expect(first_result['episode']['number']).to eq 18}
    end

    context "with given options" do
      Given do
        stub_request(:get, "https://api-v2launch.trakt.tv/calendars/my/shows/#{from_date}/#{days}")
          .with(headers: {'Authorization' => "Bearer #{token}"})
          .to_return(body: JSON.parse(File.new('spec/fixtures/trakt/calendars/shows.json').read))
      end

      Given(:from_date){Date.today-1.week}
      Given(:days){30}
      When(:result){subject.shows(from_date: from_date, days: days)}
      
      Then{expect(result.size).to eq 11}
    end
  end
end
