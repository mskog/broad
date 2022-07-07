# typed: strict

class EpisodeRelease < ApplicationRecord
  extend T::Sig

  RESOLUTIONS = T.let(%w[720p 1080i 1080p 2160p].freeze, T::Array[String])
  SOURCES = T.let(%w[hdtv webrip web-dl].freeze, T::Array[String])
  CODECS = T.let(%w[x264 h.264 x264-hi10p x265 h.265].freeze, T::Array[String])

  belongs_to :episode, touch: true

  sig{returns(T::Boolean)}
  def killer?
    %w[2160p].include? resolution
  end

  sig{returns(T::Boolean)}
  def acceptable?
    %w[1080p 2160p].include? resolution
  end

  sig{params(other: EpisodeRelease).returns(Integer)}
  def <=>(other)
    resolution_comparison = resolution_points <=> other.resolution_points
    return resolution_comparison unless resolution_comparison == 0
    hdr_comparison = hdr_points <=> other.hdr_points
    return hdr_comparison unless hdr_comparison == 0
    codec_comparison = codec_points <=> other.codec_points
    return codec_comparison unless codec_comparison == 0
    source_points <=> other.source_points
  end

  sig{returns(Integer)}
  def resolution_points
    RESOLUTIONS.index(resolution) || -1
  end

  sig{returns(Integer)}
  def hdr_points
    hdr ? 1 : -1
  end

  sig{returns(Integer)}
  def source_points
    SOURCES.index(source) || -1
  end

  sig{returns(T.untyped)}
  def codec_points
    CODECS.index(file_encoding.to_s.downcase) || -1
  end
end
