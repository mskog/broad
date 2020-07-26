require "spec_helper"

describe Services::Trakt::Calendars do
  Given(:token){"some_token"}

  subject{described_class.new(token: token)}

  describe "#shows" do
    context "with defaults" do
      Given(:first_result){result.first}
      When(:result){subject.shows}
      Then{expect(result.size).to eq 11}
      And{expect(first_result.first_aired).to eq DateTime.parse("2016-02-24T02:00:00.000Z")}

      And{expect(first_result.episode.ids.imdb).to be_nil}
      And{expect(first_result.episode.ids.tmdb).to eq 0}
      And{expect(first_result.episode.ids.trakt).to eq 1_765_462}
      And{expect(first_result.episode.ids.tvdb).to eq 5_479_986}
      And{expect(first_result.episode.ids.tvrage).to eq 0}
      And{expect(first_result.episode.number).to eq 18}
      And{expect(first_result.episode.season).to eq 5}
      And{expect(first_result.episode.title).to eq "The Maid of Gévaudan"}

      And{expect(first_result.show.title).to eq "Teen Wolf"}
      And{expect(first_result.show.year).to eq 2011}
      And{expect(first_result.show.ids.imdb).to eq "tt1567432"}
      And{expect(first_result.show.ids.slug).to eq "teen-wolf-2011"}
      And{expect(first_result.show.ids.trakt).to eq 34_375}
      And{expect(first_result.show.ids.tvdb).to eq 175_001}
      And{expect(first_result.show.ids.tvrage).to eq 27_575}
    end

    context "with given options" do
      Given(:from_date){Date.today - 1.week}
      Given(:days){30}
      When(:result){subject.shows(from_date: from_date, days: days)}

      Then{expect(result.size).to eq 11}
    end
  end

  describe "#show_premieres" do
    context "with defaults" do
      Given(:first_result){result.first}
      When(:result){subject.show_premieres}
      Then{expect(result.size).to eq 13}
      And{expect(first_result.first_aired).to eq DateTime.parse("Fri, 01 Sep 2017 07:00:00.000000000 +0000")}

      And{expect(first_result.episode.ids.imdb).to be_nil}
      And{expect(first_result.episode.ids.tmdb).to eq 1_337_523}
      And{expect(first_result.episode.ids.trakt).to eq 2_653_541}
      And{expect(first_result.episode.ids.tvdb).to eq 6_193_382}
      And{expect(first_result.episode.ids.tvrage).to eq 0}
      And{expect(first_result.episode.number).to eq 1}
      And{expect(first_result.episode.season).to eq 3}
      And{expect(first_result.episode.title).to eq "Episode 1"}

      And{expect(first_result.show.title).to eq "Narcos"}
      And{expect(first_result.show.year).to eq 2015}
      And{expect(first_result.show.ids.imdb).to eq "tt2707408"}
      And{expect(first_result.show.ids.slug).to eq "narcos"}
      And{expect(first_result.show.ids.trakt).to eq 94_630}
      And{expect(first_result.show.ids.tvdb).to eq 282_670}
      And{expect(first_result.show.ids.tvrage).to eq 37_241}
    end

    context "with given options" do
      Given(:from_date){Date.today - 1.week}
      Given(:days){30}
      When(:result){subject.shows(from_date: from_date, days: days)}

      Then{expect(result.size).to eq 11}
    end
  end

  describe "#all_shows_new" do
    context "with defaults" do
      Given(:first_result){result.first}
      When(:result){subject.all_shows_new}
      Then{expect(result.size).to eq 48}
    end
  end
end
