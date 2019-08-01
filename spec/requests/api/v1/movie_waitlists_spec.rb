require "spec_helper"

describe "API:V1:Movies", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env["ACCEPT"] = "application/json"
  end

  Given{allow(NotifyHuginnJob).to receive(:perform_later)}

  describe "POST#create" do
    When do
      post api_v1_movie_waitlists_path, params: params, env: @env
    end

    context "with valid parameters" do
      Given(:imdb_id){"tt0386064"}
      Given(:params){{imdb_id: imdb_id}}

      Given(:expected_movie){Movie.last}

      Then{expect(response.status).to eq 200}
      And{expect(expected_movie.imdb_id).to eq "tt0386064"}
    end

    context "with an identical movie not on the waitlist" do
      Given(:imdb_id){"tt0386064"}
      Given{create :movie, imdb_id: "tt0386064"}
      Given(:params){{imdb_id: imdb_id}}

      Then{expect(Movie.count).to eq 1}
      And{expect(response.status).to eq 200}
    end
  end

  describe "DELETE" do
    When do
      delete api_v1_movie_waitlist_path(movie.id), env: @env
    end

    context "with valid parameters" do
      Given(:movie){create :movie, waitlist: true}

      Then{expect(response.status).to eq 204}
      And{expect(Movie.find_by_id(movie.id)).to be_nil}
    end

    context "with a movie that cannot be deleted" do
      Given(:movie){create :movie}

      Then{expect(response.status).to eq 422}
      And{expect(Movie.find_by_id(movie.id)).to be_present}
    end
  end

  describe "PATCH#force" do
    When do
      patch force_api_v1_movie_waitlist_path(movie.id), env: @env
    end

    context "with valid parameters" do
      Given(:movie){create :movie, waitlist: true}
      Given(:reloaded_movie){movie.reload}

      Then{expect(response.status).to eq 200}
      And{expect(reloaded_movie.waitlist).to be_falsy}
      And{expect(reloaded_movie.download_at).to be_within(1.minute).of(Time.now)}
    end

    context "with a movie not on the waitlist" do
      Given(:movie){create :movie}

      Then{expect(response.status).to eq 500}
    end
  end
end
