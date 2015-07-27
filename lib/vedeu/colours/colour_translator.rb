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
  # translate that to the 8-bit escape sequence or when you have a capable
  # terminal and the `TERM=xterm-truecolor` environment variable set,
  # a 24-bit representation.
  #
  # @todo More documentation required (create a fancy chart!)
  #
  class ColourTranslator

    # @!attribute [r] colour
    # @return [String]
    attr_reader :colour
    alias_method :value, :colour

    # Produces new objects of the correct class from the value, ignores objects
    # that have already been coerced.
    #
    # @param value [Object|NilClass]
    # @return [Object]
    def self.coerce(value)
      if value.is_a?(self)
        value

      else
        new(value)

      end
    end

    # Return a new instance of Vedeu::ColourTranslator.
    #
    # @param colour [Fixnum|String|Symbol]
    # @return [Vedeu::ColourTranslator]
    def initialize(colour = '')
      @colour = colour || ''
    end

    # An object is equal when its values are the same.
    #
    # @param other [Vedeu::Char]
    # @return [Boolean]
    def eql?(other)
      self.class == other.class && colour == other.colour
    end
    alias_method :==, :eql?

    # @return [String]
    # @see Vedeu::ColourTranslator
    def escape_sequence
      if no_colour?
        ''

      elsif registered?(colour)
        retrieve(colour)

      elsif rgb?
        rgb

      elsif numbered?
        numbered

      elsif named?
        named

      else
        ''

      end
    end
    alias_method :to_s, :escape_sequence
    alias_method :to_str, :escape_sequence

    # @return [String]
    def to_html
      if rgb?
        colour

      else
        ''

      end
    end

    private

    # Retrieves the escape sequence for the HTML/CSS colour code.
    #
    # @param colour [String]
    # @return [String]
    def retrieve(colour)
      repository.retrieve(colour)
    end

    # Registers a HTML/CSS colour code and escape sequence to reduce processing.
    #
    # @param colour [String] A HTML/CSS colour code.
    # @param escape_sequence [String] The HTML/CSS colour code as an escape
    #   sequence.
    # @return [String]
    def register(colour, escape_sequence)
      repository.register(colour, escape_sequence)
    end

    # Returns a boolean indicating the HTML/CSS colour code has been registered.
    #
    # @param colour [String]
    # @return [Boolean]
    def registered?(colour)
      repository.registered?(colour)
    end

    # @return [Boolean]
    def no_colour?
      colour.nil? || colour.to_s.empty?
    end

    # @return [Boolean]
    def named?
      colour.is_a?(Symbol) && valid_name?
    end

    # Returns an escape sequence for a named background colour.
    #
    # @note
    #   Valid names can be found at {Vedeu::Esc#codes}
    #
    # @return [String]
    def named
      ["\e[", named_codes, 'm'].join
    end

    # Returns a boolean indicating whether the colour provided is a valid named
    # colour.
    #
    # @return [Boolean]
    def valid_name?
      Vedeu::Esc.codes.keys.include?(colour)
    end

    # Returns a boolean indicating whether the colour provided is a terminal
    # numbered colour.
    #
    # @return [Boolean]
    def numbered?
      colour.is_a?(Fixnum) && valid_range?
    end

    # Returns an escape sequence.
    #
    # @return [String]
    def numbered
      [numbered_prefix, css_to_numbered, 'm'].join
    end

    # Returns a boolean indicated whether the colour is a valid HTML/CSS colour.
    #
    # @return [Boolean]
    def rgb?
      return true if colour =~ /^#([A-Fa-f0-9]{6})$/

      false
    end

    # Returns an escape sequence.
    #
    # @return [String]
    def rgb
      if Vedeu::Configuration.colour_mode == 16_777_216
        register(colour, format(rgb_prefix, *css_to_rgb))

      else
        numbered

      end
    end

    # Returns a boolean indicating whether the numbered colour is within the
    # range of valid terminal numbered colours.
    #
    # @return [Boolean]
    def valid_range?
      colour >= 0 && colour <= 255
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
        colour[5..6].to_i(16),
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

    # Takes the red component of {#css_to_rgb} and converts to the correct value
    # for setting the terminal red value.
    #
    # @return [Fixnum]
    def red
      (css_to_rgb[0] / 51) * 36
    end

    # Takes the green component of {#css_to_rgb} and converts to the correct
    # value for setting the terminal green value.
    #
    # @return [Fixnum]
    def green
      (css_to_rgb[1] / 51) * 6
    end

    # Takes the blue component of {#css_to_rgb} and converts to the correct
    # value for setting the terminal blue value.
    #
    # @return [Fixnum]
    def blue
      (css_to_rgb[2] / 51) * 1
    end

    # @raise [Vedeu::NotImplemented] Subclasses of this class must implement
    #   this method.
    # @return [Vedeu::NotImplemented]
    def not_implemented
      fail Vedeu::NotImplemented, 'Subclasses implement this.'
    end
    alias_method :named_codes,     :not_implemented
    alias_method :numbered_prefix, :not_implemented
    alias_method :repository,      :not_implemented
    alias_method :rgb_prefix,      :not_implemented

  end # ColourTranslator

end # Vedeu
