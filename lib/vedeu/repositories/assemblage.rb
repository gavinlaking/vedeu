# frozen_string_literal: true

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
      # @param index [Integer|Range]
      # @return [void]
      def [](index)
        collection[index]
      end

      # Returns a boolean indicating whether the collection is not
      # empty.
      #
      # @macro param_block
      # @return [Boolean]
      def any?(&block)
        collection.any?(&block)
      end

      # Provides iteration over the collection.
      #
      # @macro param_block
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
        self.class.equal?(other.class) && collection == other.collection
      end
      alias == eql?

      # Return the size of the collection.
      #
      # @return [Integer]
      def size
        collection.size
      end

    end # Collection

  end # Repositories

end # Vedeu
