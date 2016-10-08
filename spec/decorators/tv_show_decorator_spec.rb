require 'spec_helper'

describe TvShowDecorator, :nodb do
  Given(:tmdb_details){{}}
  Given(:tv_show){build_stubbed :tv_show, tmdb_details: tmdb_details}
  subject{described_class.new(tv_show)}

  describe "#poster" do
    Given(:tmdb_details){{"poster_path" => '/sdfsfsd.jpg'}}

    context "with default size" do
      When(:result){subject.poster}
      Then{expect(result).to eq "https://image.tmdb.org/t/p/w300#{tmdb_details['poster_path']}"}
    end

    context "with poster size 300" do
      When(:result){subject.poster(poster_size)}
      Given(:poster_size){300}
      Then{expect(result).to eq "https://image.tmdb.org/t/p/w300#{tmdb_details['poster_path']}"}
    end

    context "with no poster available" do
      When(:result){subject.poster(poster_size)}
      Given(:tmdb_details){{}}
      Given(:poster_size){300}
      Then{expect(result).to eq h.image_url('murray_300x169.jpg')}
    end
  end
end
