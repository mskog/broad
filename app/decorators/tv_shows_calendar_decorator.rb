# TODO Specs
# TODO Can this be done better?
class TvShowsCalendarDecorator < Draper::Decorator
  delegate_all

  def by_date
    super.each_with_object({}) do |(date, group), object|
      object[date] = group.map do |tv_show|
        TvShowDecorator.decorate tv_show
      end
    end
  end

  def watching
    super
    self
  end
end
