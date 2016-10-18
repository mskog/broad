require 'spec_helper'

describe Services::Trakt::Calendars do
  Given(:token){'some_token'}

  subject{described_class.new(token: token)}

  describe "#shows" do
    context "with defaults" do
      Given(:first_result){result.first}
      When(:result){subject.shows}
      Then{expect(result.size).to eq 11}
      And{expect(first_result.first_aired).to eq DateTime.parse('2016-02-24T02:00:00.000Z')}

      And{expect(first_result.episode.ids.imdb).to be_nil}
      And{expect(first_result.episode.ids.tmdb).to eq 0}
      And{expect(first_result.episode.ids.trakt).to eq 1765462}
      And{expect(first_result.episode.ids.tvdb).to eq 5479986}
      And{expect(first_result.episode.ids.tvrage).to eq 0}
      And{expect(first_result.episode.number).to eq 18}
      And{expect(first_result.episode.season).to eq 5}
      And{expect(first_result.episode.title).to eq 'The Maid of Gévaudan'}

      And{expect(first_result.show.title).to eq 'Teen Wolf'}
      And{expect(first_result.show.year).to eq 2011}
      And{expect(first_result.show.ids.imdb).to eq 'tt1567432'}
      And{expect(first_result.show.ids.slug).to eq 'teen-wolf-2011'}
      And{expect(first_result.show.ids.trakt).to eq 34375}
      And{expect(first_result.show.ids.tvdb).to eq 175001}
      And{expect(first_result.show.ids.tvrage).to eq 27575}
    end

    context "with given options" do
      Given(:from_date){Date.today-1.week}
      Given(:days){30}
      When(:result){subject.shows(from_date: from_date, days: days)}

      Then{expect(result.size).to eq 11}
    end
  end
end
