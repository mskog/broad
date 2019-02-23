require 'spec_helper'

describe "API:V1:Movies", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env['ACCEPT'] = 'application/json'
  end

  describe "Index" do
    Given(:params){{}}
    Given!(:movie_waitlist){create :movie, waitlist: true}
    Given!(:movie_downloaded){create :movie, waitlist: false}
    Given!(:movie_watched){create :movie, watched: true}

    When do
      get api_v1_movies_path, env: @env, params: params
    end

    context "with no category" do
      Given(:parsed_response){JSON.parse(response.body)}
      Given(:first_result){parsed_response.first}

      Then{expect(response.status).to eq 200}
      And{expect(parsed_response.count).to eq 3}
    end

    context "with downloaded movies" do
      Given(:params){{category: 'downloads'}}
      Given(:parsed_response){JSON.parse(response.body)}
      Given(:first_result){parsed_response.first}

      Then{expect(response.status).to eq 200}
      And{expect(parsed_response.count).to eq 2}
      And{expect(first_result['title']).to eq movie_downloaded.title}
    end

    context "with waitlist movies" do
      Given(:params){{category: 'waitlist'}}
      Given(:parsed_response){JSON.parse(response.body)}
      Given(:first_result){parsed_response.first}

      Then{expect(response.status).to eq 200}
      And{expect(parsed_response.count).to eq 1}
      And{expect(first_result['title']).to eq movie_waitlist.title}
    end

    context "with watched movies" do
      Given(:params){{category: 'watched'}}
      Given(:parsed_response){JSON.parse(response.body)}
      Given(:first_result){parsed_response.first}

      Then{expect(response.status).to eq 200}
      And{expect(parsed_response.count).to eq 1}
      And{expect(first_result['title']).to eq movie_watched.title}
    end
  end
end
