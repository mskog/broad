# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `FetchMovieDetailsJob`.
# Please instead update this file by running `bin/tapioca dsl FetchMovieDetailsJob`.

class FetchMovieDetailsJob
  class << self
    sig { params(movie: T.untyped).returns(T.any(FetchMovieDetailsJob, FalseClass)) }
    def perform_later(movie); end

    sig { params(movie: T.untyped).returns(T.untyped) }
    def perform_now(movie); end
  end
end
