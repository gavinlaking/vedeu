module Vedeu

  module Editor

    # Manipulate a single line from the view.
    #
    class Line

      include Vedeu::Common

      # Return a new instance of Vedeu::Editor::Line.
      #
      # @param line [String|NilClass] The line of text.
      # @param x [Fixnum|NilClass] Represents the cursor position on the line.
      # @return [Vedeu::Editor::Line]
      def initialize(line:, x:)
        @line  = line
        @x     = x || 0
        @chars = present?(line) ? line.chars : []
      end

      # Delete a character from the line.
      #
      # @return [Vedeu::Editor::Line]
      def delete
        if x_position > 0 && x_position <= (size - 1)
          @chars[x_position] = nil
          @chars.compact

          left
        end

        self
      end

      # Insert a character into the line.
      #
      # @param character [String]
      # @return [Vedeu::Editor::Line]
      def insert(character)
        if empty? || x_position == (size - 1)
          @chars = chars.push(character)

        else
          @chars = chars.insert(x, character)

        end

        right

        self
      end

      # Return the current virtual cursor position.
      #
      # @return [Fixnum]
      def x_position
        if x <= 0
          @x = 0

        elsif x > (size - 1)
          @x = size - 1

        else
          @x

        end
      end

      # Return the line.
      #
      # @return [String]
      def render
        chars.join
      end

      protected

      # @!attribute [rw] chars
      # @return [Array<String>|Array<void>]
      attr_reader :chars

      # @!attribute [r] line
      # @return [String]
      attr_reader :line

      # @!attribute [rw] x
      # @return [Fixnum]
      attr_accessor :x

      private

      # Return a boolean indicating whether the line is empty.
      #
      # @return [Boolean]
      def empty?
        line && line.empty?
      end

      # Move the current virtual cursor to the right.
      #
      # @return [Fixnum]
      def right
        if x > (size - 1)
          @x = size - 1

        else
          @x += 1

        end
      end

      # Move the current virtual cursor to the left.
      #
      # @return [Fixnum]
      def left
        if x <= 0
          @x = 0

        elsif x > (size - 1)
          @x = (size - 1) - 1

        else
          @x -= 1

        end
      end

      # Return the size of the line.
      #
      # @return [Fixnum]
      def size
        return 0 if empty?

        chars.size
      end

    end # Line

  end # Editor

end # Vedeu
