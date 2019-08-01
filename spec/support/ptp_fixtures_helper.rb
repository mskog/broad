module PTPFixturesHelper
  class << self
    def build_stubbed(title)
      data = JSON.parse(File.open("spec/fixtures/ptp/#{title.underscore}.json").read)

      movie = FactoryBot.build_stubbed(:movie, title: data["Movies"][0]["Title"])

      data["Movies"][0]["Torrents"].each do |release|
        domain_release = Services::PTP::Release.new(release)
        movie.association(:releases).add_to_target(FactoryBot.build_stubbed(:movie_release, domain_release.to_h.except(:id, :width, :height).merge(ptp_movie_id: domain_release.id)))
      end
      yield movie if block_given?
      movie
    end

    def create(title)
      data = JSON.parse(File.open("spec/fixtures/ptp/#{title.underscore}.json").read)

      movie = FactoryBot.create(:movie, title: data["Movies"][0]["Title"])

      data["Movies"][0]["Torrents"].each do |release|
        domain_release = Services::PTP::Release.new(release)
        movie.releases << FactoryBot.create(:movie_release, domain_release.to_h.except(:id, :width, :height).merge(ptp_movie_id: domain_release.id))
      end
      yield movie if block_given?
      movie
    end
  end
end
