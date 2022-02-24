module Domain
  module Ptp
    # TODO: Move specs
    class Movie < SimpleDelegator
      def initialize(movie, **)
        super movie
      end
    end
  end
end
