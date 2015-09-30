require 'spec_helper'

describe MovieRelease do
  it{is_expected.to belong_to :movie}
end
