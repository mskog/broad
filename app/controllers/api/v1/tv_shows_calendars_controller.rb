class Api::V1::TvShowsCalendarsController < Api::ApiController
  def show
    @view = TvShowsCalendarDecorator.decorate ViewObjects::TvShowsCalendar.new(cache_key_prefix: 'watching')
    render json: @view.by_date
  end
end
