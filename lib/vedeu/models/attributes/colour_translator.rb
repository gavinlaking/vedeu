module Vedeu
  class ColourTranslator

    # Convert a CSS/HTML colour string into a terminal escape sequence.
    #
    # If provided with an empty value or a string it cannot convert, it will
    # return an empty string.
    #
    # When provided with a named colour, uses the terminal's value for that
    # colour. If a theme is being used with the terminal, which overrides the
    # defaults, then the theme's colour will be used. The recognised names are:
    # :black, :red, :green, :yellow, :blue, :magenta, :cyan, :white, :default.
    #
    # TODO: add more documentation
    #
    # @param colour [String]
    # @return [String]
    def self.escape_sequence(colour = '')
      new(colour).escape_sequence
    end

    # @param colour [String]
    # @return [ColourTranslator]
    def initialize(colour = '')
      @colour = colour
    end

    # @return [String]
    # @see Vedeu::ColourTranslator.escape_sequence
    def escape_sequence
      if no_colour?
        ''

      elsif named?
        named

      elsif numbered?
        numbered

      elsif rgb?
        rgb

      else
        ''

      end
    end

    private

    attr_reader :colour

    # @return [TrueClass|FalseClass]
    def no_colour?
      colour.nil? || colour.to_s.empty?
    end

    # @return [TrueClass|FalseClass]
    def named?
      colour.is_a?(Symbol) && valid_name?
    end

    # @return [Exception]
    def named
      fail NotImplemented, 'Subclasses implement this.'
    end

    # @return [TrueClass|FalseClass]
    def valid_name?
      codes.keys.include?(colour)
    end

    # @return [TrueClass|FalseClass]
    def numbered?
      colour.is_a?(Fixnum) && valid_range?
    end

    # @return [Exception]
    def numbered
      fail NotImplemented, 'Subclasses implement this.'
    end

    # @return [TrueClass|FalseClass]
    def valid_range?
      colour >= 0 && colour <= 255
    end

    # @return [TrueClass|FalseClass]
    def rgb?
      colour.is_a?(String) && valid_rgb?
    end

    # @return [Exception]
    def rgb
      fail NotImplemented, 'Subclasses implement this.'
    end

    # @return [TrueClass|FalseClass]
    def valid_rgb?
      !!(colour =~ /^#([A-Fa-f0-9]{6})$/)
    end

    # @return [Array]
    def css_to_rgb
      [
        colour[1..2].to_i(16),
        colour[3..4].to_i(16),
        colour[5..6].to_i(16)
      ]
    end

    # @return [Fixnum]
    def css_to_numbered
      if rgb?
        [16, red, green, blue].inject(:+)

      elsif numbered?
        colour

      end
    end

    # @return [Fixnum]
    def red
      (css_to_rgb[0] / 51) * 36
    end

    # @return [Fixnum]
    def green
      (css_to_rgb[1] / 51) * 6
    end

    # @return [Fixnum]
    def blue
      (css_to_rgb[2] / 51) * 1
    end

    # @return [Hash]
    def codes
      {
        black:   30,
        red:     31,
        green:   32,
        yellow:  33,
        blue:    34,
        magenta: 35,
        cyan:    36,
        white:   37,
        default: 39,
      }
    end

  end
end
