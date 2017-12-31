# frozen_string_literal: true

module Vedeu

  module Editor

    # Maintains a cursor position within the {Vedeu::Editor::Document}
    # class.
    #
    # @api private
    #
    class Cursor

      extend Forwardable

      def_delegators :geometry,
                     :bx,
                     :bxn,
                     :by,
                     :byn

      # @!attribute [r] name
      # @macro return_name
      attr_reader :name

      # @!attribute [rw] ox
      # @return [Integer]
      attr_accessor :ox

      # @!attribute [rw] oy
      # @return [Integer]
      attr_accessor :oy

      # @!attribute [rw] x
      # @return [Integer]
      attr_writer :x

      # @!attribute [rw] y
      # @return [Integer]
      attr_writer :y

      # Returns a new instance of Vedeu::Editor::Cursor.
      #
      # @param attributes [Hash<Symbol => Integer|String|Symbol>]
      # @option attributes y [Integer] The current line.
      # @option attributes x [Integer] The current character within the
      #   line.
      # @option attributes name [String|Symbol]
      # @option attributes oy [Integer]
      # @option attributes ox [Integer]
      # @return [Vedeu::Editor::Cursor]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # Move the virtual cursor to the beginning of the line.
      #
      # @return [Vedeu::Editor::Cursor]
      def bol
        @ox = 0
        @x  = 0

        self
      end

      # Move the virtual cursor down by one line.
      #
      # @param size [Integer] The number of characters on the next
      #   line. The cursor is placed at the end of this next line if
      #   the x coordinate is greater than the next line length.
      # @return [Vedeu::Editor::Cursor]
      def down(size = nil)
        @y += 1
        @x = size if size && x > size

        self
      end

      # Move the virtual cursor to the left.
      #
      # @return [Vedeu::Editor::Cursor]
      def left
        @ox -= 1 unless @ox == 0
        @x -= 1

        self
      end

      # Overwrite the cursor of the same name. This ensure that on
      # refresh the cursor stays in the correct position for the
      # document being edited.
      #
      # @return [Vedeu::Editor::Cursor]
      # @todo Should ox/oy be 0; or set to @ox/@oy? (GL: 2015-10-02)
      def refresh
        Vedeu::Cursors::Cursor.store(new_attributes)

        Vedeu.trigger(:_refresh_cursor_, name)

        self
      end

      # Move the virtual cursor to the origin (0, 0).
      #
      # @return [Vedeu::Editor::Cursor]
      def reset!
        @x  = 0
        @y  = 0
        @ox = 0
        @oy = 0

        self
      end

      # Move the virtual cursor to the right.
      #
      # @return [Vedeu::Editor::Cursor]
      def right
        @x += 1

        self
      end

      # Return the escape sequence as a string for setting the cursor
      # position and show the cursor.
      #
      # @return [String]
      def to_s
        "\e[#{real_y};#{real_x}H\e[?25h"
      end
      alias to_str to_s

      # Move the virtual cursor up by one line.
      #
      # @param size [Integer] The number of characters on the next
      #   line. The cursor is placed at the end of this next line if
      #   the x coordinate is greater than the next line length.
      # @return [Vedeu::Editor::Cursor]
      def up(size = nil)
        @oy -= 1 unless @oy == 0
        @y -= 1
        @x = size if size && x > size

        self
      end

      # @return [Integer] The column/character coordinate.
      def x
        @x  = 0               if @x <= 0
        @ox = @x - (bxn - bx) if @x > bxn - bx

        @x
      end

      # @return [Integer] The row/line coordinate.
      def y
        @y  = 0               if @y <= 0
        @oy = @y - (byn - by) if @y > byn - by

        @y
      end

      private

      # @macro geometry_by_name
      def geometry
        @geometry ||= Vedeu.geometries.by_name(name)
      end

      # @macro defaults_method
      def defaults
        {
          name: nil,
          ox:   0,
          oy:   0,
          x:    0,
          y:    0,
        }
      end

      # Return the real y coordinate.
      #
      # @return [Integer]
      def real_y
        (by + y) - oy
      end

      # Return the real x coordinate.
      #
      # @return [Integer]
      def real_x
        (bx + x) - ox
      end

      # @return [Hash<Symbol => Integer, String, Symbol>]
      def new_attributes
        {
          name:    name,
          x:       real_x,
          y:       real_y,
          ox:      0,
          oy:      0,
          visible: true,
        }
      end

    end # Cursor

  end # Editor

end # Vedeu
