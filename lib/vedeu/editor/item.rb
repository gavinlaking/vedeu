module Vedeu

  module Editor

    # Fetches an item from a collection.
    #
    # @api private
    #
    class Item

      # @param (see #initialize)
      # @return (see #by_index)
      def self.by_index(collection, index = nil)
        new(collection, index).by_index
      end

      # Returns a new instance of Vedeu::Editor::Item.
      #
      # @param collection [Vedeu::Editor::Line|Vedeu::Editor::Lines]
      # @param index [Fixnum]
      # @return [Vedeu::Editor::item]
      def initialize(collection, index = nil)
        @collection = collection
        @index      = index
      end

      # @return [String|Vedeu::Editor::Line]
      def by_index
        return nil unless size > 0

        if index.nil? || index > size
          collection[-1]

        elsif index > 0 && index <= size
          collection[index]

        else
          collection[0]

        end
      end

      protected

      # @!attribute [r] collection
      # @return [Vedeu::Editor::Line|Vedeu::Editor::Lines]
      attr_reader :collection

      # @!attribute [r] index
      # @return [Fixnum]
      attr_reader :index

      private

      # Returns the size of the collection or 0.
      #
      # @return [Fixnum]
      def size
        if collection
          collection.size

        else
          0

        end
      end

    end # Item

  end # Editor

end # Vedeu
