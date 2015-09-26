require 'spec_helper'

describe Domain::PTP::Release do
  Given(:data) do
    {
        "Checked" => true,
        "Codec" => "x264",
        "Container" => "MKV",
        "GoldenPopcorn" => false,
        "Id" => 383077,
        "Leechers" => "0",
        "Quality" => "Standard Definition",
        "ReleaseName" => "Jurassic.World.2015.BDRip.x264-SPARKS",
        "Resolution" => "720x360",
        "Scene" => true,
        "Seeders" => "160",
        "Size" => "1609991092",
        "Snatched" => "181",
        "Source" => "Blu-ray",
        "UploadTime" => "2015-09-25 09:19:09"
    }
  end

  subject{described_class.new(data)}

  Then{expect(subject.checked).to be_truthy}
  And{expect(subject.codec).to eq 'x264'}
  And{expect(subject.container).to eq 'mkv'}
  And{expect(subject.golden_popcon).to be_falsy}
  And{expect(subject.id).to eq 383077}
  And{expect(subject.leechers).to eq 0}
  And{expect(subject.seeders).to eq 160}
  And{expect(subject.quality).to eq 'standard definition'}
  And{expect(subject.release_name).to eq 'jurassic.world.2015.bdrip.x264-sparks'}
  And{expect(subject.resolution).to eq '720x360'}
  And{expect(subject.scene).to be_truthy}
  And{expect(subject.size).to eq 1609991092}
  And{expect(subject.snatched).to eq 181}
  And{expect(subject.source).to eq "blu-ray"}
  And{expect(subject.upload_time).to eq DateTime.parse("2015-09-25 09:19:09")}

  And{expect(subject.width).to eq 720}
  And{expect(subject.height).to eq 360}
end
