require "spec_helper"

describe MovieRelease do
  it{should belong_to(:movie)}

  it_behaves_like "has a valid factory"
end
