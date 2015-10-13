require 'spec_helper'

describe Services::OverwatchMoviesCheck do
  describe "#perform" do
    When{subject.perform}

    context "something" do
      Given!(:movie){create :movie, overwatch: true}
    end
  end
end
