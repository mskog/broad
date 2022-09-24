require "spec_helper"

describe Services::Btn::Feed, :nodb do
  Given(:url){"http://www.example.com/foobar.rss"}
  subject{described_class.new(url)}

  describe "entries" do
    context "with successful fetch and parse" do
      Given(:fixture){File.read("spec/fixtures/btn_feed.xml")}
      Given{stub_request(:get, url).to_return(body: fixture)}
      When(:result){subject.to_a}
      Then{expect(result.count).to eq 9}
      And{expect(result.first.name).to eq "Hannibal"}
      And{expect(result.first.url).to eq "https://broadcasthe.net/torrents.php?action=download&authkey=sdjfisdjfsdifjsdifj&torrent_pass=dfsdfdsfsdfsdf&id=532251"}
      And{expect(result.first.published_at).to eq "2015-07-19 10:55:35.000000000 +0000"}
    end

    context "when Btn is down" do
      Given(:fixture){File.read("spec/fixtures/btn_feed_down.txt")}
      Given{stub_request(:get, url).to_return(body: fixture)}
      When(:result){subject.to_a}
      Then{result == Failure(described_class::BtnIsProbablyDownError)}
    end
  end

  describe "#published_since" do
    Given(:fixture){File.read("spec/fixtures/btn_feed.xml")}
    Given{stub_request(:get, url).to_return(body: fixture)}

    When(:result){subject.published_since(datetime).to_a}

    context "with a date that is later than the last item in the feed" do
      Given(:datetime){"2016-01-01"}
      Then{expect(result.count).to eq 0}
    end

    context "with a date" do
      Given(:datetime){"2015-07-18"}
      Then{expect(result.count).to eq 3}
      And{expect(result.all?{|entry| entry.published_at >= datetime}).to be_truthy}
      And{expect(result.last.name).to eq "Wayward Pines"}
    end
  end
end
