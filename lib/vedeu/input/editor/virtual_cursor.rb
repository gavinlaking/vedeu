module Vedeu

  module Editor

    class VirtualCursor

      # @!attribute [rw] x
      # @return [Fixnum]
      attr_accessor :x

      # @!attribute [rw] y
      # @return [Fixnum]
      attr_accessor :y

      # @param y [Fixnum]
      # @param x [Fixnum]
      # @return [Vedeu::Editor::VirtualCursor]
      def initialize(y: 0, x: 0)
        @y = (y.nil? || y < 0) ? 0 : y
        @x = (x.nil? || x < 0) ? 0 : x
      end

      # Move the virtual cursor down by one line.
      #
      # @return [Fixnum]
      def down
        @y += 1
      end

      # Move the virtual cursor to the left.
      #
      # @return [Fixnum]
      def left
        @x -= 1
      end

      # Move the virtual cursor to the right.
      #
      # @return [Fixnum]
      def right
        @x += 1
      end

      # Move the virtual cursor up by one line.
      #
      # @return [Fixnum]
      def up
        @y -= 1
      end

    end # VirtualCursor

  end # Editor

end # Vedeu
