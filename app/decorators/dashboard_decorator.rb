class DashboardDecorator < Draper::Decorator
  def movies_waitlist
    MovieDecorator.decorate_collection(object.movies_waitlist)
  end
end
