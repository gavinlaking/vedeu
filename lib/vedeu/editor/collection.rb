module Vedeu

  module Editor

    module Collection

      # Return an individual element or collection of elements (if
      # the given index is a Range).
      #
      # @param index [Fixnum|Range]
      # @return
      #   [String|Vedeu::Editor::Line|Array<String>|
      #     Array<Vedeu::Editor::Line>]
      def [](index)
        collection[index]
      end

      # Returns a boolean indicating whether the collection is empty.
      #
      # @return [Boolean]
      def empty?
        collection.empty?
      end

      # An object is equal when its values are the same.
      #
      # @param other [void]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && collection == other.collection
      end
      alias_method :==, :eql?

      # Fetches an item from a collection.
      #
      # @param index [Fixnum]
      # @return [String]
      def by_index(index)
        Vedeu::Editor::Item.by_index(collection, index)
      end

      # Return the size of the collection.
      #
      # @return [Fixnum]
      def size
        collection.size
      end

    end # Collection

  end # Editor

end # Vedeu
