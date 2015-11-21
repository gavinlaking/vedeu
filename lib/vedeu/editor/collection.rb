module Vedeu

  module Editor

    module Collection

      include Vedeu::Repositories::Assemblage

      # Fetches an item from a collection.
      #
      # @param index [Fixnum]
      # @return [String]
      def by_index(index)
        Vedeu::Editor::Item.by_index(collection, index)
      end

    end # Collection

  end # Editor

end # Vedeu
