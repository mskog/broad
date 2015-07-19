require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  every(30.minutes, 'Downloaded updates from BTN Feed') do
    time = Release.maximum(:published_at) || Time.parse('1970-01-01')
    Services::FetchAndPersistFeedEntries.new(ENV['BTN_FEED_URL'], time).perform
  end
end
