require 'spec_helper'

describe Release do
  it{is_expected.to belong_to :episode}
end
