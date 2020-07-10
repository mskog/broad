module Types::OmnisearchResultType
  include Types::BaseInterface

  definition_methods do
    def resolve_type(object, _context)
      "Types::#{object.class.name}Type".constantize
    end
  end
end
