module ViewObjects
  module Support
    module Paginatable

      PER_PAGE = 15

      def paginate(page:, per_page: PER_PAGE)
        __setobj__ __getobj__.page(page).per(per_page)
        self
      end
    end
  end
end
