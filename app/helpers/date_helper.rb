# typed: true
module DateHelper
  def human_date(date)
    if date == Date.today
      "Today"
    elsif date == Date.yesterday
      "Yesterday"
    else
      date
    end
  end
end
