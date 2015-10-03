require 'spec_helper'

describe Movie do
  it{is_expected.to have_many :movie_releases}
end
