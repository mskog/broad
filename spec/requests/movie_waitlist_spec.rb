require "spec_helper"

describe "Movies", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env["ACCEPT"] = "application/rss+xml"
  end

  describe "Create" do
    When do
      post movie_waitlists_path, params: params, env: @env
    end

    context "with valid parameters" do
      Given(:imdb_url){"http://www.imdb.com/title/tt0386064/?ref_=fn_al_tt_2"}
      Given(:params){{query: imdb_url}}

      Given(:expected_movie){Movie.last}

      Then{expect(expected_movie.imdb_id).to eq "tt0386064"}
    end

    context "with an identical movie not on the waitlist" do
      Given{create :movie, imdb_id: "tt0386064"}
      Given(:imdb_url){"http://www.imdb.com/title/tt0386064/?ref_=fn_al_tt_2"}
      Given(:params){{query: imdb_url}}

      Then{expect(Movie.count).to eq 1}
    end
  end

  describe "Force" do
    When do
      put force_movie_waitlist_path(movie.id), params: params, env: @env
    end

    context "with valid parameters" do
      Given(:movie){create :movie, waitlist: true}
      Given(:params){{id: movie.id}}

      Given(:updated_movie){movie.reload}

      Then{expect(updated_movie.download_at).to_not be_nil}
      And{expect(updated_movie.download_at).to be <= Time.now}
    end

    # context "with a movie that is not on waitlist" do
    #   Given(:movie){create :movie, waitlist: false}
    #   Given(:params){{id: movie.id}}

    #   Given(:updated_movie){movie.reload}

    #   Then{expect(updated_movie.download_at).to be_nil}
    # end
  end
end
