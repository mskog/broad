# typed: true
module Types
  class ProgressShow < Types::BaseObject
    field :aired_episodes, Integer, null: false
    field :completed_episodes, Integer, null: false
    field :last_collected_at, String, null: false
    field :seasons, [Types::ProgressSeason], null: false

    field :completed, Boolean, null: false

    def aired_episodes
      object.aired
    end

    def completed_episodes
      object.completed
    end

    def completed
      object.completed?
    end
  end
end
