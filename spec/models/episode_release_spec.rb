require 'spec_helper'

describe EpisodeRelease do
  it{is_expected.to belong_to :episode}
end
