require "spec_helper"

describe Services::Ptp::Movie do
  subject{described_class.new(data)}

  Given(:data){JSON.parse(File.read("spec/fixtures/ptp/jurassic_world.json"))["Movies"][0]}
  Given(:auth_key){"hello"}
  Given{data[:auth_key] = auth_key}
  Given{data[:releases] = data["Torrents"]}

  describe "#attributes" do
    Then{expect(subject.title).to eq "Jurassic World"}
    And{expect(subject.auth_key).to eq auth_key}
    And{expect(subject.imdb_id).to eq "0369610"}
  end

  describe "#releases" do
    When(:result){subject.releases}
    Then{expect(result.count).to eq 5}
    And{expect(result.first.resolution).to eq "720x360"}
  end
end
