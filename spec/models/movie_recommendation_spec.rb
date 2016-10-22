require 'spec_helper'

describe MovieRecommendation do
  it{is_expected.to validate_presence_of :title}
  it{is_expected.to validate_uniqueness_of :imdb_id}
  it{is_expected.to validate_uniqueness_of :tmdb_id}
  it{is_expected.to validate_uniqueness_of :trakt_id}
end
