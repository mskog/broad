require 'spec_helper'

describe DashboardDecorator, :nodb do
  subject{described_class.new(dashboard)}

  Given(:dashboard){OpenStruct.new(movies_waitlist: [build_stubbed(:movie, waitlist: true)])}

  describe "#movies_waitlist" do
    When(:result){subject.movies_waitlist}
    Then{expect(result.first).to be_decorated_with(MovieDecorator)}
  end
end
