# typed: strict

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `FetchNewMovieReleasesJob`.
# Please instead update this file by running `bin/tapioca dsl FetchNewMovieReleasesJob`.

class FetchNewMovieReleasesJob
  class << self
    sig { params(movie: T.untyped).returns(T.any(FetchNewMovieReleasesJob, FalseClass)) }
    def perform_later(movie); end

    sig { params(movie: T.untyped).returns(T.untyped) }
    def perform_now(movie); end
  end
end
