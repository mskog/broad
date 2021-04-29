require "spec_helper"

describe Services::BTN::Api, :nodb do
  subject{described_class.new}

  describe "#sample" do
    Given(:client_mock){instance_double("Services::BTN::Client")}
    subject{described_class.new(client_mock)}

    When(:result){subject.sample(tvdb_id)}

    context "with a show with matching torrents" do
      Given(:response){JSON.parse(File.read("spec/fixtures/btn/getTorrents/sample_strain.json"))}
      Given{allow(client_mock).to receive(:call).with("getTorrents", name: "S01E01", :tvdb => tvdb_id, :category => :episode).and_return(response)}
      Given(:tvdb_id){276_564}

      Then{expect(result.count).to eq 8}
      And{expect(result.map(&:season).uniq).to eq [1]}
      And{expect(result.map(&:episode).uniq).to eq [1]}
    end

    context "with nothing found, but a season 1 exists" do
      Given(:response_episode){JSON.parse(File.read("spec/fixtures/btn/getTorrents/foobar.json"))}
      Given(:response_season){JSON.parse(File.read("spec/fixtures/btn/getTorrents/338946.json"))}
      Given{allow(client_mock).to receive(:call).with("getTorrents", name: "S01E01", :tvdb => tvdb_id, :category => :episode).and_return(response_episode)}
      Given{allow(client_mock).to receive(:call).with("getTorrents", name: "Season 1", :tvdb => tvdb_id, :category => :season).and_return(response_season)}
      Given(:tvdb_id){9999}

      Then{expect(result.count).to eq 3}
    end

    context "with nothing found" do
      Given(:response){JSON.parse(File.read("spec/fixtures/btn/getTorrents/foobar.json"))}
      Given{allow(client_mock).to receive(:call).with("getTorrents", name: "S01E01", :tvdb => tvdb_id, :category => :episode).and_return(response)}
      Given{allow(client_mock).to receive(:call).with("getTorrents", name: "Season 1", :tvdb => tvdb_id, :category => :season).and_return(response)}
      Given(:tvdb_id){9999}

      Then{expect(result.count).to eq 0}
    end
  end

  describe "#season" do
    Given(:client_mock){instance_double("Services::BTN::Client")}
    subject{described_class.new(client_mock)}

    When(:result){subject.season(tvdb_id, 1)}

    context "with a show with matching torrents" do
      Given(:response){JSON.parse(File.read("spec/fixtures/btn/getTorrents/338946.json"))}
      Given{allow(client_mock).to receive(:call).with("getTorrents", name: "Season 1", :tvdb => tvdb_id, :category => :season).and_return(response)}
      Given(:tvdb_id){276_564}

      Then{expect(result.count).to eq 3}
      And{expect(result.map(&:season).uniq).to eq [1]}
    end

    context "with nothing found" do
      Given(:response){JSON.parse(File.read("spec/fixtures/btn/getTorrents/foobar.json"))}
      Given{allow(client_mock).to receive(:call).with("getTorrents", name: "Season 1", :tvdb => tvdb_id, :category => :season).and_return(response)}
      Given(:tvdb_id){9999}

      Then{expect(result.count).to eq 0}
    end
  end

  describe "#episode" do
    Given(:client_mock){instance_double("Services::BTN::Client")}
    subject{described_class.new(client_mock)}

    When(:result){subject.episode(tvdb_id, 1, 5)}

    context "with a show with matching torrents" do
      Given(:response){JSON.parse(File.read("spec/fixtures/btn/getTorrents/338946_episode.json"))}
      Given{allow(client_mock).to receive(:call).with("getTorrents", name: "S01E05", :tvdb => tvdb_id, :category => :episode).and_return(response)}
      Given(:tvdb_id){276_564}

      Then{expect(result.count).to eq 3}
      And{expect(result.map(&:season).uniq).to eq [1]}
      And{expect(result.map(&:episode).uniq).to eq [5]}
    end

    context "with nothing found" do
      Given(:response){JSON.parse(File.read("spec/fixtures/btn/getTorrents/foobar.json"))}
      Given{allow(client_mock).to receive(:call).with("getTorrents", name: "S01E05", :tvdb => tvdb_id, :category => :episode).and_return(response)}
      Given(:tvdb_id){9999}

      Then{expect(result.count).to eq 0}
    end
  end

  describe "#get_torrents" do
    When(:result){subject.get_torrents(search_attributes)}
    Given(:first_result){result.first}

    context "when searching by raw name for an existing show" do
      Given(:search_attributes){"House"}
      Then{expect(result.count).to eq 1}
      And{expect(first_result.season).to eq 10}
    end

    context "when searching by attributes for an existing show" do
      Given(:search_attributes){{series: "House"}}
      Then{expect(result.count).to eq 1}
      And{expect(first_result.season).to eq 10}
    end

    context "when searching by raw name for an existing show with no results" do
      Given(:search_attributes){"foobar"}
      Then{expect(result.count).to eq 0}
    end
  end
end
