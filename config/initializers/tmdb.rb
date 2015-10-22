Tmdb::Api.key(ENV['TMDB_APIKEY'])

module Broad
  def self.tmdb_configuration
    data = Rails.cache.fetch("tmdb_configuration", expires_in: 3.days) do
      configuration = Tmdb::Configuration.new
      thing = {
        base_url: configuration.base_url,
        secure_base_url: configuration.secure_base_url,
        poster_sizes: configuration.poster_sizes,
        backdrop_sizes: configuration.backdrop_sizes,
        profile_sizes: configuration.profile_sizes,
        logo_sizes: configuration.logo_sizes,
      }
    end
    OpenStruct.new(data)
  end
end
