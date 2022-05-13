require "spec_helper"

describe Season do
  it{is_expected.to belong_to(:tv_show)}
  it{is_expected.to have_many(:episodes).dependent(:destroy)}

  describe "#aired?" do
    subject{build_stubbed :season, episodes: episodes}

    context "with no episodes" do
      Given(:episodes){[]}
      Then{expect(subject).not_to be_aired}
    end

    context "with only aired episodes" do
      Given(:episodes){[build_stubbed(:episode, air_date: Time.zone.yesterday), build_stubbed(:episode, air_date: Time.zone.yesterday)]}
      Then{expect(subject).to be_aired}
    end

    context "with only unaired episodes" do
      Given(:episodes){[build_stubbed(:episode, air_date: Time.zone.tomorrow), build_stubbed(:episode, air_date: Time.zone.tomorrow)]}
      Then{expect(subject).not_to be_aired}
    end

    context "with a mix of aired and unaired episodes" do
      Given(:episodes){[build_stubbed(:episode, air_date: Time.zone.tomorrow), build_stubbed(:episode, air_date: Time.zone.yesterday)]}
      Then{expect(subject).not_to be_aired}
    end
  end
end
