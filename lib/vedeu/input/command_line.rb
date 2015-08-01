module Vedeu

  class CommandLine

    # @!attribute [rw] x
    # @return [Fixnum]
    attr_accessor :x

    # @!attribute [rw] y
    # @return [Fixnum]
    attr_accessor :y

    # Return a new instance of Vedeu::CommandLine.
    #
    # @param attributes [Hash<Symbol => void>]
    # @option attributes text [String] The text already entered if any.
    # @option attributes x [Fixnum] The cursor x position within the
    #   entered text.
    # @option attributes y [Fixnum] The cursor y position within the
    #   entered text.
    # @return [Vedeu::CommandLine]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)

      @attributes.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def delete
      if text.empty?
        ''

      else
        @line = line(@y)
        @line.slice!(@x, 1)
        @line.join

      end
    end

    def insert(character)
      @line = line.insert(x, character).join

      progress

      @line
    end

    # Moves the position forward by one character or down into next line, until
    # there are no more characters or lines.
    #
    # @return [void]
    def progress
      if text.empty?
        @x

      elsif @x == line(@y).size - 1 # end of current line
        if @y >= lines.size - 1 # on last line already
          @x

        else
          @x = 0
          @y = @y += 1

        end
      else
        @x = @x += 1

      end
    end

    # Moves the position backward by one character or up into previous line,
    # until the position is [0, 0].
    #
    # @return [void]
    def regress
      if text.empty? || (@x == 0 && @y == 0)
        @x

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

    # @!attribute [rw] text
    # @return [String]
    attr_accessor :text

    private

    # @return [Hash<Symbol => void>]
    def attributes
      {
        text: text,
        x:    x,
        y:    y,
      }
    end

    def characters_per_line
      counts = []
      lines.each_with_index do |line, index|
        counts << line(index).size
      end
      counts
    end

    # @return [String]
    def column(xi = x)
      return '' if line.empty?

      line[xi]
    end

    # @return [Array<String>]
    def line(yi = y)
      return '' if lines.empty?

      lines[yi].chars
    end

    # @return [Array<String>]
    def lines
      return [''] if text.lines.empty?

      @lines = text.lines.map(&:chomp)
    end

    # @return [Hash<Symbol => void>]
    def defaults
      {
        text: '',
        x:    0,
        y:    0,
      }
    end

  end # CommandLine

end # Vedeu
