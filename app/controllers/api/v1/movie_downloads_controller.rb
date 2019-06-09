module Api
  module V1
    class MovieDownloadsController < ApiController
      def create
        @view = Domain::PTP::Movie.new(build_movie)
        @view.fetch_new_releases
        @view.has_acceptable_release? ? create_acceptable_release : create_unacceptable_release
      end

      private

      def create_acceptable_release
        @view.save
        head 200
      end

      def create_unacceptable_release
        head 422
      end

      def build_movie
        imdb = Services::Imdb.from_data(create_params[:query])
        Movie.find_or_initialize_by(imdb_id: imdb.id) do |movie|
          movie.download_at = Time.now
        end
      end

      def create_params
        params.permit(:query)
      end
    end
  end
end
