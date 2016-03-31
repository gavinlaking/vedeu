# frozen_string_literal: true

module Vedeu

  module Buffers

    # Provides a grid of Vedeu::Cells::Empty objects at the given
    # height and width.
    #
    # @api private
    #
    class Empty

      include Vedeu::Repositories::Defaults

      # @!attribute [r] name
      # @return [NilClass|String|Symbol]
      attr_reader :name

      # @!attribute [r] x
      # @return [Fixnum]
      attr_reader :x

      # @!attribute [r] y
      # @return [Fixnum]
      attr_reader :y

      # @return [Array<Array<Vedeu::Cells::Empty>>]
      def buffer
        @buffer ||= empty
      end

      # @return [Fixnum]
      def height
        @height + 1
      end

      # @return [Fixnum]
      def width
        @width + 1
      end

      private

      # @macro defaults_method
      def defaults
        {
          height: Vedeu.height,
          name:   nil,
          width:  Vedeu.width,
          x:      1,
          y:      1,
        }
      end

      # @return [Array<Array<Vedeu::Cells::Empty>>]
      def empty
        Array.new(height) do
          Array.new(width) do
            Vedeu::Cells::Empty.new(name: name)
          end
        end
      end

    end # Empty

  end # Buffers

end # Vedeu
