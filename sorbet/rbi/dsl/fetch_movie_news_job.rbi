# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `FetchMovieNewsJob`.
# Please instead update this file by running `bin/tapioca dsl FetchMovieNewsJob`.

class FetchMovieNewsJob
  class << self
    sig { returns(T.any(FetchMovieNewsJob, FalseClass)) }
    def perform_later; end

    sig { returns(T.untyped) }
    def perform_now; end
  end
end
