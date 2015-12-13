module Vedeu

  module Repositories

    # Provides collection related query/command methods.
    #
    # @api private
    #
    module Assemblage

      include Enumerable

      # Return an individual element or collection of elements (if
      # the given index is a Range).
      #
      # @param index [Fixnum|Range]
      # @return [void]
      def [](index)
        collection[index]
      end

      # Returns a boolean indicating whether the collection is not
      # empty.
      #
      # @return [Boolean]
      def any?
        collection.any?
      end

      # Provides iteration over the collection.
      #
      # @param block [Proc]
      # @return [Enumerator]
      def each(&block)
        collection.each(&block)
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

      # Return the size of the collection.
      #
      # @return [Fixnum]
      def size
        collection.size
      end

    end # Collection

  end # Repositories

end # Vedeu
