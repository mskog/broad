require 'spec_helper'

describe Episode do
  it{is_expected.to have_many(:releases)}
end
