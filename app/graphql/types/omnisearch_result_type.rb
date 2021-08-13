module Types::OmnisearchResultType
  include Types::BaseInterface

  field :title, String, null: true

  definition_methods do
    def resolve_type(object, _context)
      "Types::#{object.class.name}Type".constantize
    end
  end
end
