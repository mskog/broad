require 'spec_helper'

describe "Movie Deletion", type: :request do
  include AuthHelper
  before(:each) do
    http_login
    @env['ACCEPT'] = 'application/rss+xml'
  end

  describe "Create" do
    When do
      delete movie_path(movie), {}, @env
    end

    context "with a deletable movie" do
      Given(:movie){create :movie, download_at: Date.tomorrow}
      Then{expect(Movie.count).to eq 0}
    end

    context "with a movie that cannot be deleted" do
      Given(:movie){create :movie, download_at: Date.yesterday}
      Then{expect(Movie.count).to eq 1}
    end
  end
end
