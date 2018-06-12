require 'spec_helper'

describe TvShow do
  it{is_expected.to have_many(:episodes)}

  it_behaves_like 'has a valid factory'

end
