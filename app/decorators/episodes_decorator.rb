class EpisodesDecorator < PaginatingDecorator
  def grouped_by_published_date
    group_by{ |episode| episode.published_at.to_date}
  end

  def grouped_by_created_date
    group_by{ |episode| episode.created_at.to_date}
  end
end
