# TODO: Rename to notifications in general and do not have the code in the job itself
class NotifyHuginnJob < ActiveJob::Base
  def perform(message)
    HTTP.basic_auth(user: ENV["NOTIFICATIONS_USER"], pass: ENV["NOTIFICATIONS_PASSWORD"]).post(ENV["NOTIFICATIONS_URL"], json: {message: message})
  end
end
