class TvShowsCalendarController < ApplicationController
  def index
    @view = ViewObjects::TvShowsCalendar.new
  end
end
