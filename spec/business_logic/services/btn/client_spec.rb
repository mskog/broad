require 'spec_helper'

describe Services::BTN::Client do
  describe "#call" do
    context "with a method that exists" do
      Given(:method){'getTorrents'}
      Given(:search){{series: 'House'}}
      When(:result){subject.call(method, search)}
      Then{expect(result['torrents']['953987']['Series']).to eq 'The Real Housewives of New York City'}
    end
  end
end