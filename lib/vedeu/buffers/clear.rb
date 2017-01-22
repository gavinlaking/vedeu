# frozen_string_literal: true

module Vedeu

  module Buffers

    # Provides a grid of Vedeu::Cells::Clear objects at the given
    # height and width.
    #
    # @api private
    #
    class Clear

      include Vedeu::Repositories::Defaults

      # @!attribute [r] name
      # @return [NilClass|String|Symbol]
      attr_reader :name

      # @return [Array<Array<Vedeu::Cells::Clear>>]
      def buffer
        @buffer ||= clear
      end

      # @return [Integer]
      def height
        @height + 1
      end

      # @return [Integer]
      def width
        @width + 1
      end

      private

      # @macro interface_by_name
      def interface
        @_interface ||= Vedeu.interfaces.by_name(name)
      end

      # @macro defaults_method
      def defaults
        {
          height: Vedeu.height,
          name:   nil,
          width:  Vedeu.width,
        }
      end

      # @return [Array<Array<Vedeu::Cells::Clear>>]
      def clear
        Array.new(height) do
          Array.new(width) do
            Vedeu::Cells::Clear.new(colour: interface.colour, name: name)
          end
        end
      end

    end # Clear

  end # Buffers

end # Vedeu
