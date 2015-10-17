require 'spec_helper'

describe MovieReleaseDecorator, :nodb do
  subject{described_class.new(movie_release)}

  Given(:movie_release){build_stubbed :movie_release}

  describe "#release_name" do
    Then{expect(subject.release_name).to eq 'Jurassic.World.2015.Bdrip.X264 Sparks'}
  end

  describe "#container" do
    Then{expect(subject.container).to eq 'MKV'}
  end

  describe "#size" do
    Then{expect(subject.size).to eq '1.5 GB'}
  end

  describe "#source" do
    Then{expect(subject.source).to eq 'Blu Ray'}
  end

  describe "#joined_attributes" do
    context "with all of the attributes" do
      When(:result){subject.joined_attributes}
      Then{expect(result).to eq "Blu Ray - 1080p - MKV - 1.5 GB - Remux"}
    end

    context "with only some attributes" do
      When(:result){subject.joined_attributes}
      Given(:movie_release){build_stubbed :movie_release, version_attributes: []}
      Then{expect(result).to eq "Blu Ray - 1080p - MKV - 1.5 GB"}
    end

    context "with a set separator" do
      When(:result){subject.joined_attributes(",")}
      Then{expect(result).to eq "Blu Ray,1080p,MKV,1.5 GB,Remux"}
    end
  end
end
