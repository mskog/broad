# typed: strict

class MovieRelease < ApplicationRecord
  extend T::Sig

  belongs_to :movie, touch: true

  COMPARISON_METHODS = T.let(%w[resolution source container codec remux].freeze, T::Array[String])

  RESOLUTIONS = T.let(%w[720p 1080i 1080p 2160p].freeze, T::Array[String])
  CONTAINERS = T.let(["mkv"].freeze, T::Array[String])
  CODECS = T.let(%w[x264 h.264 x265 h.265].freeze, T::Array[String])
  SOURCE_POINTS = T.let(%w[web hd-dvd blu-ray].freeze, T::Array[String])

  sig{returns(String)}
  def download_url
    "http://passthepopcorn.me/torrents.php?action=download&id=#{ptp_movie_id}&authkey=#{auth_key}&torrent_pass=#{ENV['PTP_PASSKEY']}"
  end

  sig{params(other: MovieRelease).returns(Integer)}
  def <=>(other)
    COMPARISON_METHODS.each do |method|
      comparison = public_send("#{method}_points") <=> other.public_send("#{method}_points")
      return comparison unless comparison == 0
    end
    T.must(size) <=> T.must(other.size)
  end

  sig{returns(Integer)}
  def resolution_points
    RESOLUTIONS.index(resolution) || -1
  end

  sig{returns(Integer)}
  def container_points
    CONTAINERS.index(container) || -1
  end

  sig{returns(Integer)}
  def codec_points
    CODECS.index(codec) || -1
  end

  sig{returns(Integer)}
  def source_points
    SOURCE_POINTS.index(source) || -1
  end

  sig{returns(Integer)}
  def remux_points
    version_attributes.include?("remux") ? 1 : 0
  end
end
