module Vedeu

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
  # When a number between 0 and 255 is provided, Vedeu will use the terminal
  # colour corresponding with that colour.
  #
  # Finally, when provided a CSS/HTML colour string e.g. '#ff0000', Vedeu will
  # translate that to the 8-bit escape sequence or if you have a capable
  # terminal and the `VEDEU_TERM=xterm-truecolor` environment variable set,
  # a 24-bit representation.
  #
  # @todo More documentation required (create a fancy chart!)
  # @api private
  class ColourTranslator

    # Convert a CSS/HTML colour string into a terminal escape sequence.
    #
    # @param colour [String]
    # @return [String]
    def self.escape_sequence(colour = '')
      new(colour).escape_sequence
    end

    # Return a new instance of ColourTranslator.
    #
    # @param colour [String]
    # @return [ColourTranslator]
    def initialize(colour = '')
      @colour = colour
    end

    # @return [String]
    # @see Vedeu::ColourTranslator
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

    # @api private
    # @return [Boolean]
    def no_colour?
      colour.nil? || colour.to_s.empty?
    end

    # @api private
    # @return [Boolean]
    def named?
      colour.is_a?(Symbol) && valid_name?
    end

    # @api private
    # @raise [NotImplemented] Subclasses of this class must implement this
    #   method.
    # @return [Exception]
    def named
      fail NotImplemented, 'Subclasses implement this.'
    end

    # @api private
    # @return [Boolean]
    def valid_name?
      codes.keys.include?(colour)
    end

    # @api private
    # @return [Boolean]
    def numbered?
      colour.is_a?(Fixnum) && valid_range?
    end

    # @api private
    # @raise [NotImplemented] Subclasses of this class must implement this
    #   method.
    # @return [NotImplemented]
    def numbered
      fail NotImplemented, 'Subclasses implement this.'
    end

    # @api private
    # @return [Boolean]
    def valid_range?
      colour >= 0 && colour <= 255
    end

    # @api private
    # @return [Boolean]
    def rgb?
      colour.is_a?(String) && valid_rgb?
    end

    # @api private
    # @raise [NotImplemented] Subclasses of this class must implement this
    #   method.
    # @return [NotImplemented]
    def rgb
      fail NotImplemented, 'Subclasses implement this.'
    end

    # @api private
    # @return [Boolean]
    def valid_rgb?
      !!(colour =~ /^#([A-Fa-f0-9]{6})$/)
    end

    # @api private
    # @return [Array]
    def css_to_rgb
      [
        colour[1..2].to_i(16),
        colour[3..4].to_i(16),
        colour[5..6].to_i(16)
      ]
    end

    # @api private
    # @return [Fixnum]
    def css_to_numbered
      if rgb?
        [16, red, green, blue].inject(:+)

      elsif numbered?
        colour

      end
    end

    # @api private
    # @return [Fixnum]
    def red
      (css_to_rgb[0] / 51) * 36
    end

    # @api private
    # @return [Fixnum]
    def green
      (css_to_rgb[1] / 51) * 6
    end

    # @api private
    # @return [Fixnum]
    def blue
      (css_to_rgb[2] / 51) * 1
    end

    # @api private
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

  end # ColourTranslator

end # Vedeu
