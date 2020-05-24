class TvShow < ActiveRecord::Base
  serialize :tmdb_details, Hash
  serialize :trakt_details, Hash

  after_commit :fetch_details, :on => :create
  after_commit :cable_update, :on => :update

  has_many :episodes, dependent: :destroy

  scope :watching, ->{where("waitlist = false AND (status = 'returning series' OR status IS NULL)").where(watching: true)}
  scope :not_watching, ->{where("waitlist = false AND (status = 'returning series' OR status IS NULL)").where(watching: false)}
  scope :ended, ->{where.not(status: "returning series")}
  scope :on_waitlist, ->{where("waitlist = true")}

  def poster_image(size = 1280)
    return nil unless tmdb_details.key?("poster_path")
    image = tmdb_details["poster_path"]
    "#{Broad.tmdb_configuration.secure_base_url}w#{size}/#{image}"
  end

  def backdrop_image
    return nil unless tmdb_details.key?("backdrop_path")
    image = tmdb_details["backdrop_path"]
    "#{Broad.tmdb_configuration.secure_base_url}w1280#{image}"
  end

  private

  def fetch_details
    FetchTvShowDetailsTmdbJob.perform_later self
    FetchTvShowDetailsTraktJob.perform_later self
    cable_update
  end

  def cable_update
    view = TvShowDecorator.decorate(ViewObjects::TvShow.new(self))
    ActionCable.server.broadcast "updates_channel", type: "tv_shows", id: id, body: TvShowSerializer.new(view).to_json
  end
end
