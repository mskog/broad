# typed: strict

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `FetchTvShowDetailsTmdbJob`.
# Please instead update this file by running `bin/tapioca dsl FetchTvShowDetailsTmdbJob`.

class FetchTvShowDetailsTmdbJob
  class << self
    sig { params(tv_show: T.untyped).returns(T.any(FetchTvShowDetailsTmdbJob, FalseClass)) }
    def perform_later(tv_show); end

    sig { params(tv_show: T.untyped).returns(T.untyped) }
    def perform_now(tv_show); end
  end
end
