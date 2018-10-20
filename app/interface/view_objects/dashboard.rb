module ViewObjects
  class Dashboard
    def movies_waitlist
      Movie.on_waitlist
    end

    def episodes_today
      Episodes.new(Episode.where("published_at::date = ?", Date.today).order(id: :desc))
    end

    def episodes_week
      Episodes.new(Episode.where("published_at::date >= ?", Date.today.beginning_of_week).order(id: :desc))
    end
  end
end
