require 'spec_helper'

describe MovieReleaseDecorator, :nodb do
  subject{described_class.new(movie_release)}

  Given(:movie_release){build_stubbed :movie_release}

  describe "#release_name" do
    Then{expect(subject.release_name).to eq 'Jurassic.World.2015.Bdrip.X264 Sparks'}
  end
end
