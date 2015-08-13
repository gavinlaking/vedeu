module Vedeu

  module Editor

    class CommandLine

      # Return a new instance of Vedeu::Editor::CommandLine.
      #
      # @param attributes [Hash<Symbol => void>]
      # @option attributes text [String] The text already entered if any.
      # @option attributes x [Fixnum] The cursor x position within the
      #   entered text.
      # @option attributes y [Fixnum] The cursor y position within the
      #   entered text.
      # @option attributes name [String] The name of the interface which 'owns'
      #   this command line. This is used to get display options and geometry.
      # @return [Vedeu::Editor::CommandLine]
      def initialize(attributes = {})
        @attributes = defaults.merge!(attributes)

        @attributes.each { |key, value| instance_variable_set("@#{key}", value) }
      end

      # Deletes the character from the line where the cursor is currently
      # positioned.
      #
      # @return [void]
      def delete
        if text.empty?
          @lines = ''

        else
          @lines = lines

          tmp_line = line(@y)
          tmp_line.slice!(@x, 1)

          @lines[@y] = tmp_line.join
          @lines.join("\n")
        end
      end

      def input
        # loop do

        # end
      end

      # Inserts the given character in to the line where the cursor is currently
      # positioned.
      #
      # @param character [String]
      # @return [void]
      def insert(character)
        @lines = line(@y).insert(@x, character).join

        progress

        @lines
      end

      # Moves the position forward by one character or down into next line, until
      # there are no more characters or lines.
      #
      # @return [void]
      def progress
        if text.empty?
          x

        elsif x == line(y).size - 1 # end of current line
          if y >= lines.size - 1 # on last line already
            x

          else
            @x = 0
            @y = @y += 1

          end
        else
          @x = @x += 1

        end
      end

      # @return [Boolean]
      def raw_mode?
        false
      end

      # Moves the position backward by one character or up into previous line,
      # until the position is [0, 0].
      #
      # @return [void]
      def regress
        if text.empty? || (@x == 0 && @y == 0)
          x

        elsif @x == 0 && @y > 0
          @y = @y -= 1
          @x = line(@y).index(line(@y).last)

        else
          @x = @x -= 1

        end
      end

      # @return [String]
      def render
        out = []
        lines.each_with_index do |line, yi|
          unless line.empty?
            outline = ""

            line(yi).each_with_index do |column, xi|
              outline << if yi == @y && xi == @x
                           "\e[7m#{column}\e[27m"

                         else
                           column

                         end
            end

            outline << "\n"
            out << outline
          end
        end
        out.join
      end

      protected

      # @!attribute [rw] y
      # @return [String]
      attr_reader :name

      # @!attribute [rw] text
      # @return [String]
      attr_accessor :text

      # @!attribute [rw] x
      # @return [Fixnum]
      attr_accessor :x

      # @!attribute [rw] y
      # @return [Fixnum]
      attr_accessor :y

      private

      # @return [Hash<Symbol => void>]
      def attributes
        {
          text: text,
          x:    x,
          y:    y,
        }
      end

      # @return [Array<String>]
      def column(xi = x)
        return '' if line(y).empty?

        line(y)
      end

      # @return [Array<String>]
      def line(yi = y)
        return '' if lines.empty?
        # return '' if lines[yi].empty?

        lines[yi].chars
      end

      # @return [Array<String>]
      def lines
        return [''] if text.lines.empty?

        text.lines.map(&:chomp)
      end

      # @return [Vedeu::Geometry]
      def geometry
        @geometry ||= Vedeu.geometry.by_name(name)
      end

      # @return [Hash<Symbol => Fixnum,String>]
      def defaults
        {
          name: '',
          text: '',
          x:    0,
          y:    0,
        }
      end

    end # CommandLine

  end # Editor

end # Vedeu
