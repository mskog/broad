class EpisodeReleaseDecorator < Draper::Decorator
  delegate_all

  def joined_attributes
    "#{object.source.upcase} - #{resolution}"
  end
end
