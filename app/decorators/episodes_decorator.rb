class EpisodesDecorator < PaginatingDecorator
  def grouped_by_published_date
    group_by do |episode|
      episode.published_at.to_date
    end
  end
end
