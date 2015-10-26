module ViewObjects
  class Dashboard
    def movies_waitlist
      Movie.on_waitlist
    end
  end
end
