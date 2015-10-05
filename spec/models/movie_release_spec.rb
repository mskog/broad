require 'spec_helper'

describe MovieRelease do
  it{should belong_to(:movie)}
end
