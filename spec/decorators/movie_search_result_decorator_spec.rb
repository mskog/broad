require "spec_helper"

describe MovieSearchResultDecorator, :nodb do
  subject{described_class.new(movie)}

  describe "#poster" do
    When(:result){subject.poster}

    context "with a poster" do
      Given(:movie){OpenStruct.new(poster: "someimage.jpg")}
      Then{expect(result).to eq movie.poster}
    end

    context "with no poster" do
      Given(:movie){OpenStruct.new(poster: nil)}
      Then{expect(result).to eq h.image_url("murray.jpg")}
    end
  end

  describe "#rt_url" do
    Given(:movie){OpenStruct.new(title: "The Matrix")}
    When(:result){subject.rt_url}
    Then{expect(result).to eq "http://www.rottentomatoes.com/search/?search=#{movie.title}"}
  end
end
