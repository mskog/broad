# typed: strict

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `RefreshTraktTokenJob`.
# Please instead update this file by running `bin/tapioca dsl RefreshTraktTokenJob`.

class RefreshTraktTokenJob
  class << self
    sig { returns(T.any(RefreshTraktTokenJob, FalseClass)) }
    def perform_later; end

    sig { returns(T.untyped) }
    def perform_now; end
  end
end
