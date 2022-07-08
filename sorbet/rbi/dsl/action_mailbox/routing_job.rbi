# typed: strict

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `ActionMailbox::RoutingJob`.
# Please instead update this file by running `bin/tapioca dsl ActionMailbox::RoutingJob`.

class ActionMailbox::RoutingJob
  class << self
    sig { params(inbound_email: T.untyped).returns(T.any(ActionMailbox::RoutingJob, FalseClass)) }
    def perform_later(inbound_email); end

    sig { params(inbound_email: T.untyped).returns(T.untyped) }
    def perform_now(inbound_email); end
  end
end
