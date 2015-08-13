module Vedeu

  module Editor

    class Lines

      include Vedeu::Common

      # Return a new instance of Vedeu::Editor::Lines.
      #
      # @param text [String] The lines of text.
      # @param y [Fixnum|NilClass] Represents the row cursor position.
      # @param x [Fixnum|NilClass] Represents the column cursor position.
      # @return [Vedeu::Editor::Lines]
      def initialize(text:, y:, x:)
        @text  = text
        @y     = y || 0
        @x     = x || 0
        @lines = present?(text) ? text.lines.map(&:chomp) : []
      end

      # Return the current virtual cursor position.
      #
      # @return [Fixnum]
      def y_position
        if y <= 0
          @y = 0

        elsif y > (size - 1)
          @y = size - 1

        else
          @y

        end
      end

      # Return the lines.
      #
      # @return [String]
      def render
        lines.join("\n")
      end

      protected

      # @!attribute [rw] lines
      # @return [Array<String>|Array<void>]
      attr_reader :lines

      # @!attribute [r] text
      # @return [String]
      attr_reader :text

      # @!attribute [rw] y
      # @return [Fixnum]
      attr_accessor :y

      # @!attribute [rw] x
      # @return [Fixnum]
      attr_accessor :x

      private

      # Move the current virtual cursor down by one line.
      #
      # @return [Fixnum]
      def down
        if y > (size - 1)
          @y = size - 1

        else
          @y += 1

        end
      end

      # Return a boolean indicating whether there are any lines.
      #
      # @return [Boolean]
      def empty?
        lines && lines.empty?
      end

      # @return [Vedeu::Editor::Line]
      def line
        Vedeu::Editor::Line.new(line: lines[y_position], x: @x)
      end

      def tmp_x
        @x = line.x_position
      end

      # Return the number of lines.
      #
      # @return [Fixnum]
      def size
        return 0 if empty?

        lines.size
      end

      # Move the current virtual cursor up by one line.
      #
      # @return [Fixnum]
      def up
        if y <= 0
          @y = 0

        elsif y > (size - 1)
          @y = (size - 1) - 1

        else
          @y -= 1

        end
      end

    end # Lines

  end # Editor

end # Vedeu
