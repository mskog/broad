class NotifyHuginnJob < ActiveJob::Base
  def perform(message)
    Faraday.post(ENV['HUGINN_NOTIFICATIONS_URL']) do |request|
      request.body = {message: message}
    end
  end
end
