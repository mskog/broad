require 'spec_helper'

describe MoviePostersDecorator do
  subject{described_class.new(data)}

  describe "#url" do
    When(:result){subject.url}

    context "with posters" do
      Given(:data) do
        {
          "posters"=>
            [{"aspect_ratio"=>"0.705820105820106", "file_path"=>"/m41bMsStxq7rkI7xVTTjuqubf4I.jpg", "height"=>945, "iso_639_1"=>nil, "vote_average"=>5.23809523809524, "vote_count"=>1, "width"=>667}]
        }
      end
      Then{expect(result).to eq 'https://thumbs.picyo.me/https://image.tmdb.org/t/p/w300/m41bMsStxq7rkI7xVTTjuqubf4I.jpg'}
    end

    context "with posters, but empty" do
      Given(:data){{"posters" => []}}
      Then{expect(result).to eq h.image_url('murray_300x169.jpg')}
    end

    context "without posters" do
      Given(:data){{}}
      Then{expect(result).to eq h.image_url('murray_300x169.jpg')}
    end
  end
end
