class MovieRelease < ApplicationRecord
  belongs_to :movie, touch: true

  COMPARISON_METHODS = %w[resolution source container codec remux].freeze

  RESOLUTIONS = %w[720p 1080i 1080p 2160p].freeze
  CONTAINERS = ["mkv"].freeze
  CODECS = %w[x264 h.264 x265 h.265].freeze
  SOURCE_POINTS = %w[web hd-dvd blu-ray].freeze

  def download_url
    "http://passthepopcorn.me/torrents.php?action=download&id=#{ptp_movie_id}&authkey=#{auth_key}&torrent_pass=#{ENV['PTP_PASSKEY']}"
  end

  def <=>(other)
    COMPARISON_METHODS.each do |method|
      comparison = public_send("#{method}_points") <=> other.public_send("#{method}_points")
      return comparison unless comparison == 0
    end
    size <=> other.size
  end

  def resolution_points
    RESOLUTIONS.index(resolution) || -1
  end

  def container_points
    CONTAINERS.index(container) || -1
  end

  def codec_points
    CODECS.index(codec) || -1
  end

  def source_points
    SOURCE_POINTS.index(source) || -1
  end

  def remux_points
    version_attributes.include?("remux") ? 1 : 0
  end
end
