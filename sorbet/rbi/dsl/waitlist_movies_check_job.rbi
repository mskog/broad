# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `WaitlistMoviesCheckJob`.
# Please instead update this file by running `bin/tapioca dsl WaitlistMoviesCheckJob`.

class WaitlistMoviesCheckJob
  class << self
    sig { returns(T.any(WaitlistMoviesCheckJob, FalseClass)) }
    def perform_later; end

    sig { returns(T.untyped) }
    def perform_now; end
  end
end
