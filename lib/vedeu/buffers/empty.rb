module Vedeu

  module Buffers

    # Provides a grid of Vedeu::Models::Cell objects at the given
    # height and width.
    #
    # @api private
    class Empty

      # @!attribute [r] name
      # @return [NilClass|String|Symbol]
      attr_reader :name

      # Returns a new instance of Vedeu::Buffers::Empty.
      #
      # @note
      #   If a particular key is missing from the attributes
      #   parameter, then it is added with the respective value from
      #   #defaults.
      #
      # @param attributes [Hash<Symbol => Fixnum, NilClass, String,
      #   Symbol]
      # @option attributes name [NilClass|String|Symbol]
      # @option attributes height [Fixnum]
      # @option attributes width [Fixnum]
      # @return [Vedeu::Buffers::Empty]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value || defaults.fetch(key))
        end
      end

      # @return [Array<Array<Vedeu::Models::Cell>>]
      def buffer
        Array.new(width) do |y|
          Array.new(height) do |x|
            Vedeu::Models::Cell.new(name: name, position: [y, x])
          end
        end
      end

      # @note
      #   We add 1 to both the width and height as terminal screens
      #   are 1-indexed.
      #
      # @return [Fixnum]
      def height
        @height + 1
      end

      # @note
      #   We add 1 to both the width and height as terminal screens
      #   are 1-indexed.
      #
      # @return [Fixnum]
      def width
        @width + 1
      end

      private

      # Returns the default options/attributes for this class.
      #
      # @return [Hash<Symbol => void>]
      def defaults
        {
          height: Vedeu.height,
          name:   nil,
          width:  Vedeu.width,
        }
      end

    end # Empty

  end # Buffers

end # Vedeu
