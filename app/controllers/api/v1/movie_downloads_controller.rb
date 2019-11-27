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
        movie = Movie.find_or_initialize_by(imdb_id: imdb.id)
        movie.download_at = DateTime.now
        movie
      end

      def create_params
        params.permit(:query)
      end
    end
  end
end
