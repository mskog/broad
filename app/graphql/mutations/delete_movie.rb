module Mutations
  class DeleteMovie < BaseMutation
    argument :id, ID, required: true

    type Types::MovieType

    def resolve(id:)
      movie = Domain::PTP::Movie.new(Movie.find(id))

      if movie.deletable?
        movie.destroy
      else
        raise GraphQL::ExecutionError
      end
    end
  end
end
