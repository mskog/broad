module Types
  class ProgressSeason < Types::BaseObject
    field :number, Integer, null: false
    field :completed, Boolean, null: false
    field :aired_episodes, Integer, null: false
    field :completed_episodes, Integer, null: false

    field :episodes, [Types::ProgressEpisode], null: false

    def aired_episodes
      object.aired
    end

    def completed_episodes
      object.completed
    end
  end
end
