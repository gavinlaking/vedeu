module Vedeu

  module Editor

    class Editor

      include Vedeu::Common

      def initialize(content:, keypress:, x:, y:)
        @content  = content
        @keypress = keypress
        @x        = x || 0
        @y        = y || 0
      end

      # @return [String]
      def render
        lines.join("\n")
      end

      # Delete a character from the line.
      #
      # @return [Vedeu::Editor::Line]
      def delete_character
        if line_empty?
          ''
        elsif x_position == 0
          line

        elsif x_position > 0 && x_position <= (line_size - 1)
          new_lines = lines.dup
          new_line  = new_lines[y_position].dup
          new_line.slice!(x_position)
          new_lines[y_position] = new_line
          @lines = new_lines

          left

        end

        self
      end

      # Insert a character into the line.
      #
      # @param character [String]
      # @return [Vedeu::Editor::Line]
      def insert_character(character)
        new_lines = lines.dup
        if line_empty? || x_position == (line_size - 1)
          new_line =  new_lines[y_position] ? new_lines[y_position].dup : ''
          new_line << character

        else
          new_line = new_lines[y_position].insert(x_position, character)

        end

        new_lines[y_position] = new_line
        @lines = new_lines

        right

        self
      end

      def keypress
        if keypress.size == 1
          insert
        else

        end
      end

      # @return [Array<String|void>]
      def line
        @line = present?(lines[y]) ? lines[y] : ''
      end

      # @return [Array<String|void>]
      def lines
        @lines ||= present?(content) ? content.lines.map(&:chomp) : []
      end

      # Return the current virtual cursor position.
      #
      # @return [Fixnum]
      def x_position
        if x <= 0
          @x = 0

        elsif x > (line_size - 1)
          @x = line_size - 1

        else
          @x

        end
      end

      # Return the current virtual cursor position.
      #
      # @return [Fixnum]
      def y_position
        if y <= 0
          @y = 0

        elsif y > (lines_size - 1)
          @y = lines_size - 1

        else
          @y

        end
      end

      # Move the current virtual cursor down by one line.
      #
      # @return [Fixnum]
      def down
        if y >= (lines_size - 1)
          @y = lines_size - 1

        else
          @y += 1

        end
      end

      # Move the current virtual cursor to the left.
      #
      # @return [Fixnum]
      def left
        if x <= 0
          @x = 0

        elsif x >= (line_size - 1)
          @x = (line_size - 1) - 1

        else
          @x -= 1

        end
      end

      # Move the current virtual cursor to the right.
      #
      # @return [Fixnum]
      def right
        if x >= (line_size - 1)
          @x = line_size - 1

        else
          @x += 1

        end
      end

      # Move the current virtual cursor up by one line.
      #
      # @return [Fixnum]
      def up
        if y <= 0
          @y = 0

        elsif y >= (lines_size - 1)
          @y = (lines_size - 1) - 1

        else
          @y -= 1

        end
      end

      protected

      # @!attribute [rw] content
      # @return [void]
      attr_accessor :content

      # @!attribute [r] keypress
      # @return [void]
      attr_reader :keypress

      # @!attribute [r] x
      # @return [Fixnum]
      attr_reader :x

      # @!attribute [r] y
      # @return [Fixnum]
      attr_reader :y

      private

      # @return [Boolean]
      def lines_empty?
        lines && lines.empty?
      end

      # @return [Fixnum]
      def lines_size
        return 0 if lines_empty?

        lines.size
      end

      # @return [Boolean]
      def line_empty?
        line && line.empty?
      end

      # @return [Fixnum]
      def line_size
        return 0 if line_empty?

        line.size
      end

    end # Editor

  end # Editor

end # Vedeu
