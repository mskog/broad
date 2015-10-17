class MovieReleaseDecorator < Draper::Decorator
  delegate_all

  def release_name
    object.release_name.titleize
  end
end
