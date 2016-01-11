# frozen_string_literal: true

module Vedeu

  module Buffers

    # Provides a grid of Vedeu::Cells::Empty objects at the given
    # height and width.
    #
    # @api private
    class Empty

      include Vedeu::Repositories::Defaults

      # @!attribute [r] height
      # @return [Fixnum]
      attr_reader :height

      # @!attribute [r] name
      # @return [NilClass|String|Symbol]
      attr_reader :name

      # @!attribute [r] width
      # @return [Fixnum]
      attr_reader :width

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

      private

      # Returns the default options/attributes for this class.
      #
      # @return [Hash<Symbol => Fixnum|NilClass|String|Symbol>]
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
        Array.new(height) do |h|
          Array.new(width) do |w|
            Vedeu::Cells::Empty.new(name: name, position: [y + h, x + w])
          end
        end
      end

    end # Empty

  end # Buffers

end # Vedeu
