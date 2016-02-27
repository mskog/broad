class TvShowsCalendarController < ApplicationController
  def index
    @view = ViewObjects::TvShowsCalendar.new(cache_key_prefix: 'watching')
  end
end
