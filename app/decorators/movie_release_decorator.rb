class MovieReleaseDecorator < Draper::Decorator
  delegate_all

  def release_name
    object.release_name.to_s.titleize
  end

  def container
    object.container.to_s.upcase
  end

  def size
    h.number_to_human_size(object.size)
  end

  def source
    object.source.titleize
  end

  def joined_attributes(separator = " - ")
    version = version_attributes.map(&:titleize).join(", ")
    [source, resolution, container, size, version].reject(&:empty?).join(separator)
  end
end
