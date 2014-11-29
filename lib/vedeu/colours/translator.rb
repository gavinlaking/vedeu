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
  class Translator

    # Convert a CSS/HTML colour string into a terminal escape sequence.
    #
    # @param colour [Fixnum|String|Symbol]
    # @return [String]
    def self.escape_sequence(colour = '')
      new(colour).escape_sequence
    end

    # Return a new instance of Translator.
    #
    # @param colour [Fixnum|String|Symbol]
    # @return [Translator]
    def initialize(colour = '')
      @colour = colour
    end

    # @return [String]
    # @see Vedeu::Translator
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

    # @return [Boolean]
    def no_colour?
      colour.nil? || colour.to_s.empty?
    end

    # @return [Boolean]
    def named?
      colour.is_a?(Symbol) && valid_name?
    end

    # @raise [NotImplemented] Subclasses of this class must implement this
    #   method.
    # @return [Exception]
    def named
      fail NotImplemented, 'Subclasses implement this.'
    end

    # Returns a boolean indicating whether the colour provided is a valid named
    # colour.
    #
    # @return [Boolean]
    def valid_name?
      Esc.codes.keys.include?(colour)
    end

    # Returns a boolean indicating whether the colour provided is a terminal
    # numbered colour.
    #
    # @return [Boolean]
    def numbered?
      colour.is_a?(Fixnum) && valid_range?
    end

    # @raise [NotImplemented] Subclasses of this class must implement this
    #   method.
    # @return [NotImplemented]
    def numbered
      fail NotImplemented, 'Subclasses implement this.'
    end

    # Returns a boolean indicating whether the numbered colour is within the
    # range of valid terminal numbered colours.
    #
    # @return [Boolean]
    def valid_range?
      colour >= 0 && colour <= 255
    end

    # Returns a boolean indicated whether the colour is an HTML/CSS colour.
    #
    # @return [Boolean]
    def rgb?
      colour.is_a?(String) && valid_rgb?
    end

    # @raise [NotImplemented] Subclasses of this class must implement this
    #   method.
    # @return [NotImplemented]
    def rgb
      fail NotImplemented, 'Subclasses implement this.'
    end

    # Returns a boolean indicated whether the colour is a valid HTML/CSS colour.
    #
    # @return [Boolean]
    def valid_rgb?
      !!(colour =~ /^#([A-Fa-f0-9]{6})$/)
    end

    # Returns a collection of converted HTML/CSS octets as their decimal
    # equivalents.
    #
    # @example
    #   colour = '#aadd55'
    #   css_to_rgb # => [170, 221, 85]
    #
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

    # Takes the red component of {css_to_rgb} and converts to the correct value
    # for setting the terminal red value.
    #
    # @return [Fixnum]
    def red
      (css_to_rgb[0] / 51) * 36
    end

    # Takes the green component of {css_to_rgb} and converts to the correct value
    # for setting the terminal green value.
    #
    # @return [Fixnum]
    def green
      (css_to_rgb[1] / 51) * 6
    end

    # Takes the blue component of {css_to_rgb} and converts to the correct value
    # for setting the terminal blue value.
    #
    # @return [Fixnum]
    def blue
      (css_to_rgb[2] / 51) * 1
    end

  end # Translator

end # Vedeu
