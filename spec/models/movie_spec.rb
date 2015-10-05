require 'spec_helper'

describe Movie do
  it{is_expected.to have_many :movie_releases}
  # Then{expect(described_class).to have_many :movie_releases}
  # it{is_expected.to validate_presence_of :name}
end
