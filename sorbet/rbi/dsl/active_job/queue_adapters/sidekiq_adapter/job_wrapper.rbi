# typed: strict

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `ActiveJob::QueueAdapters::SidekiqAdapter::JobWrapper`.
# Please instead update this file by running `bin/tapioca dsl ActiveJob::QueueAdapters::SidekiqAdapter::JobWrapper`.

class ActiveJob::QueueAdapters::SidekiqAdapter::JobWrapper
  class << self
    sig { params(job_data: T.untyped).returns(String) }
    def perform_async(job_data); end

    sig { params(interval: T.any(DateTime, Time), job_data: T.untyped).returns(String) }
    def perform_at(interval, job_data); end

    sig { params(interval: Numeric, job_data: T.untyped).returns(String) }
    def perform_in(interval, job_data); end
  end
end
