class DashboardDecorator < Draper::Decorator
  MOVIES_WAITLIST_LIMIT = 10

  def movies_waitlist
    @movies_waitlist ||= MovieDecorator.decorate_collection(object.movies_waitlist)
  end

  def movies_waitlist_more?
    movies_waitlist.size > MOVIES_WAITLIST_LIMIT
  end

  def movies_waitlist_more_nbr
    movies_waitlist_more? ? movies_waitlist.size - MOVIES_WAITLIST_LIMIT : 0
  end

  def movies_waitlist_limit
    MOVIES_WAITLIST_LIMIT
  end

  def episodes_today
    EpisodeDecorator.decorate_collection object.episodes_today
  end
end
