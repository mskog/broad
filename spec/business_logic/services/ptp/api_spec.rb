require "spec_helper"

describe Services::Ptp::Api, :nodb do
  subject{described_class.new}

  Given do
    stub_request(:post, "https://passthepopcorn.me/ajax.php?action=login")
      .with(:body => {"passkey" => ENV["Ptp_PASSKEY"], "password" => ENV["Ptp_PASSWORD"], "username" => ENV["Ptp_USERNAME"]})
      .to_return(:status => 200, :body => "", :headers => {})
  end

  describe "#search" do
    When(:result){subject.search(imdb_id)}
    Given(:imdb_id){"tt0386064"}

    context "with results" do
      Given do
        stub_request(:get, "https://passthepopcorn.me/torrents.php?json=noredirect&searchstr=#{imdb_id}")
          .to_return(:status => 200, :body => File.read("spec/fixtures/ptp/brotherhood_of_war.json"))
      end

      Then{expect(result.movie.title).to eq "Taegukgi hwinalrimyeo AKA Tae Guk Gi: The Brotherhood of War"}
      And{expect(result.movie.auth_key).to eq "sdfdsfsdf"}
    end

    context "with no results" do
      Given do
        stub_request(:get, "https://passthepopcorn.me/torrents.php?json=noredirect&searchstr=#{imdb_id}")
          .to_return(:status => 200, :body => File.read("spec/fixtures/ptp/empty_search_response.json"))
      end
      Then{expect(result).not_to be_present}
    end
  end
end
