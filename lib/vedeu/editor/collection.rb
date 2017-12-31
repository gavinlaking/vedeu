# frozen_string_literal: true

module Vedeu

  module Editor

    # Used by {Vedeu::Editor::Lines} and {Vedeu::Editor::Line} to
    # fetch an item from the respective collection.
    #
    # @api private
    #
    module Collection

      include Vedeu::Repositories::Assemblage

      # Fetches an item from a collection.
      #
      # @param index [Integer]
      # @return [String]
      def by_index(index)
        Vedeu::Editor::Item.by_index(collection, index)
      end

    end # Collection

  end # Editor

end # Vedeu
