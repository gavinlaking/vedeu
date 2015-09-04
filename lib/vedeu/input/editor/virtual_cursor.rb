module Vedeu

  module Editor

    # Maintains a cursor position within the Vedeu::Editor::Document class.
    #
    class VirtualCursor

      # @!attribute [rw] bx
      # @return [Fixnum]
      attr_accessor :bx

      # @!attribute [rw] by
      # @return [Fixnum]
      attr_accessor :by

      # @!attribute [rw] bxn
      # @return [Fixnum]
      attr_accessor :bxn

      # @!attribute [rw] byn
      # @return [Fixnum]
      attr_accessor :byn

      # @!attribute [rw] ox
      # @return [Fixnum]
      attr_accessor :ox

      # @!attribute [rw] oy
      # @return [Fixnum]
      attr_accessor :oy

      # @!attribute [rw] x
      # @return [Fixnum]
      attr_accessor :x

      # @!attribute [rw] y
      # @return [Fixnum]
      attr_accessor :y

      # Returns a new instance of Vedeu::Editor::VirtualCursor.
      #
      # @param attributes [Hash]
      # @option attributes y [Fixnum] The current line.
      # @option attributes x [Fixnum] The current character with the line.
      # @option attributes by [Fixnum]
      # @option attributes bx [Fixnum]
      # @option attributes byn [Fixnum]
      # @option attributes bxn [Fixnum]
      # @option attributes oy [Fixnum]
      # @option attributes ox [Fixnum]
      # @return [Vedeu::Editor::VirtualCursor]
      def initialize(attributes = {})
        @attributes = defaults.merge!(attributes)

        @attributes.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # Move the virtual cursor to the beginning of the line.
      #
      # @return [Vedeu::Editor::VirtualCursor]
      def bol
        @ox = 0
        @x  = 0

        self
      end

      # Move the virtual cursor down by one line.
      #
      # @return [Vedeu::Editor::VirtualCursor]
      def down
        @y += 1

        self
      end

      # Move the virtual cursor to the left.
      #
      # @return [Vedeu::Editor::VirtualCursor]
      def left
        @ox -= 1 unless @ox == 0
        @x  -= 1

        self
      end

      # Move the virtual cursor to the origin (0, 0).
      #
      # @return [Vedeu::Editor::VirtualCursor]
      def reset!
        @x  = 0
        @y  = 0
        @ox = 0
        @oy = 0

        self
      end

      # Move the virtual cursor to the right.
      #
      # @return [Vedeu::Editor::VirtualCursor]
      def right
        @x += 1

        self
      end

      # Return the escape sequence for setting the cursor position and show the
      # cursor.
      #
      # @return [String]
      def to_s
        "\e[#{real_y};#{real_x}H\e[?25h"
      end

      # Move the virtual cursor up by one line.
      #
      # @return [Vedeu::Editor::VirtualCursor]
      def up
        @oy -= 1 unless @oy == 0
        @y  -= 1

        self
      end

      # @return [Fixnum] The column/character coordinate.
      def x
        @x  = 0               if @x <= 0
        @ox = @x - (bxn - bx) if @x > bxn - bx

        @x
      end

      # @return [Fixnum] The row/line coordinate.
      def y
        @y  = 0               if @y <= 0
        @oy = @y - (byn - by) if @y > byn - by

        @y
      end

      private

      # Returns the default options/attributes for this class.
      #
      # @return [Hash<Symbol => Fixnum|NilClass>]
      def defaults
        {
          y:   0,
          x:   0,
          by:  nil,
          bx:  nil,
          byn: nil,
          bxn: nil,
          ox:  0,
          oy:  0,
        }
      end

      # Return the real y coordinate.
      #
      # @return [Fixnum]
      def real_y
        (by + y) - oy
      end

      # Return the real x coordinate.
      #
      # @return [Fixnum]
      def real_x
        (bx + x) - ox
      end

    end # VirtualCursor

  end # Editor

end # Vedeu
