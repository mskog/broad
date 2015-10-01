require 'spec_helper'

describe Services::PTP::Movie do
  subject{described_class.new(data, auth_key)}
  Given(:data){JSON.parse(File.read('spec/fixtures/ptp/jurassic_world.json'))['Movies'][0]}
  Given(:auth_key){'hello'}

  describe "#attributes" do
    Then{expect(subject.title).to eq 'Jurassic World'}
    And{expect(subject.auth_key).to eq auth_key}
  end

  describe "#releases" do
    When(:result){subject.releases}
    Then{expect(result.count).to eq 5}
    And{expect(result.first.resolution).to eq "720x360"}
  end
end
