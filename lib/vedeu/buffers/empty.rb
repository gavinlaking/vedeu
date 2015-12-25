# frozen_string_literal: true

module Vedeu

  module Buffers

    # Provides a grid of Vedeu::Cells::Empty objects at the given
    # height and width.
    #
    # @api private
    class Empty

      include Vedeu::Repositories::Defaults

      # @!attribute [r] name
      # @return [NilClass|String|Symbol]
      attr_reader :name

      # @return [Array<Array<Vedeu::Cells::Empty>>]
      def buffer
        Array.new(height) do |y|
          if y > 0
            Array.new(width) do |x|
              Vedeu::Cells::Empty.new(name: name, position: [y, x]) if x > 0
            end.compact
          end
        end.compact
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
