module Mutations
  class DeleteMovie < BaseMutation
    argument :id, Integer, required: true

    type Types::MovieType

    def resolve(id:)
      movie = Movie.find(id)

      if movie.deletable?
        movie.destroy
      else
        raise GraphQL::ExecutionError
      end
    end
  end
end
