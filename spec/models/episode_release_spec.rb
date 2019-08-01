require "spec_helper"

describe EpisodeRelease do
  it{is_expected.to belong_to :episode}

  it_behaves_like "has a valid factory"
end
