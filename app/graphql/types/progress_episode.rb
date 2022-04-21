module Types
  class ProgressEpisode < Types::BaseObject
    field :number, Integer, null: false
    field :completed, Boolean, null: false
    field :collected_at, String, null: false
  end
end
