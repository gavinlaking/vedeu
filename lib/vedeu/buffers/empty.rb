module Vedeu

  module Buffers

    # Provides a grid of Vedeu::Models::Cell objects at the given
    # height and width.
    #
    # @api private
    class Empty

      include Vedeu::Repositories::Defaults

      # @!attribute [r] name
      # @return [NilClass|String|Symbol]
      attr_reader :name

      # @return [Array<Array<Vedeu::Models::Cell>>]
      def buffer
        Array.new(height) do |y|
          Array.new(width) do |x|
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
      # @return [Hash<Symbol => Fixnum|NilClass|String|Symbol>]
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
