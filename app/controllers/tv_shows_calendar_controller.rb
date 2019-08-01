class TvShowsCalendarController < ApplicationController
  def index
    @view = TvShowsCalendarDecorator.decorate ViewObjects::TvShowsCalendar.new(cache_key_prefix: "watching")
  end
end
