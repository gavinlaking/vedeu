# frozen_string_literal: true

module Vedeu

  module Colours

    # Convert a CSS/HTML colour string into a terminal escape
    # sequence.
    #
    # If provided with an empty value or a string it cannot convert,
    # it will return an empty string.
    #
    # When provided with a named colour, uses the terminal's value for
    # that colour. If a theme is being used with the terminal, which
    # overrides the defaults, then the theme's colour will be used.
    # The recognised names are:
    #
    # :black, :red, :green, :yellow, :blue, :magenta, :cyan, :white,
    # :default.
    #
    # When a number between 0 and 255 is provided, Vedeu will use the
    # terminal colour corresponding with that colour.
    #
    # Finally, when provided a CSS/HTML colour string e.g. '#ff0000',
    # Vedeu will translate that to the 8-bit escape sequence or when
    # you have a capable terminal and the `TERM=xterm-truecolor`
    # environment variable set, a 24-bit representation.
    #
    # @todo More documentation required (create a fancy chart!)
    #
    # @api private
    #
    class Translator

      extend Forwardable
      include Vedeu::Common

      def_delegators :validator,
                     :named?,
                     :rgb?,
                     :numbered?

      # @!attribute [r] colour
      # @return [String]
      attr_reader :colour
      alias value colour

      # Produces new objects of the correct class from the value,
      # ignores objects Colours::that have already been coerced.
      #
      # @param value [Object|NilClass]
      # @return [Object]
      def self.coerce(value)
        return value if value.is_a?(self)

        new(value)
      end

      # Return a new instance of Vedeu::Colours::Translator.
      #
      # @param colour [Fixnum|String|Symbol]
      # @return [Vedeu::Colours::Translator]
      def initialize(colour = '')
        @colour = colour || ''
      end

      # @return [Boolean]
      def empty?
        absent?(colour)
      end

      # An object is equal when its values are the same.
      #
      # @param other [void]
      # @return [Boolean]
      def eql?(other)
        self.class.equal?(other.class) && colour == other.colour
      end
      alias == eql?

      # @return [String]
      # @see Vedeu::Colours::Translator
      def escape_sequence
        return '' if empty?

        if registered?(colour)
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
      alias to_s escape_sequence
      alias to_str escape_sequence

      private

      # Retrieves the escape sequence for the HTML/CSS colour code.
      #
      # @param colour [String]
      # @return [String]
      def retrieve(colour)
        repository.retrieve(colour)
      end

      # Registers a HTML/CSS colour code and escape sequence to reduce
      # processing.
      #
      # @param colour [String] A HTML/CSS colour code.
      # @param escape_sequence [String] The HTML/CSS colour code as an
      #   escape sequence.
      # @return [String]
      def register(colour, escape_sequence)
        repository.register(colour, escape_sequence)
      end

      # Returns a boolean indicating the HTML/CSS colour code has been
      # registered.
      #
      # @param colour [String]
      # @return [Boolean]
      def registered?(colour)
        repository.registered?(colour)
      end

      # Returns an escape sequence.
      #
      # @return [String]
      def numbered
        format(numbered_prefix, colour)
      end

      # Returns an escape sequence.
      #
      # @return [String]
      def numbered_prefix
        "#{prefix}5;%sm"
      end

      # Returns an escape sequence.
      #
      # @return [String]
      def rgb
        if registered?(colour)
          retrieve(colour)

        elsif [8, 16, 256].include?(Vedeu.config.colour_mode)
          register(colour, format(numbered_prefix, css_to_numbered))

        elsif Vedeu.config.colour_mode == 16_777_216
          register(colour, format(rgb_prefix, *css_to_rgb))

        end
      end

      # Returns part of an escape sequence.
      #
      # @return [String]
      def rgb_prefix
        "#{prefix}2;%s;%s;%sm"
      end

      # Returns a collection of converted HTML/CSS octets as their
      # decimal equivalents.
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
        [16, red, green, blue].inject(:+)
      end

      # Takes the red component of {#css_to_rgb} and converts to the
      # correct value for setting the terminal red value.
      #
      # @return [Fixnum]
      def red
        (css_to_rgb[0] / 51) * 36
      end

      # Takes the green component of {#css_to_rgb} and converts to the
      # correct value for setting the terminal green value.
      #
      # @return [Fixnum]
      def green
        (css_to_rgb[1] / 51) * 6
      end

      # Takes the blue component of {#css_to_rgb} and converts to the
      # correct value for setting the terminal blue value.
      #
      # @return [Fixnum]
      def blue
        (css_to_rgb[2] / 51) * 1
      end

      # @macro raise_not_implemented
      def named
        raise Vedeu::Error::NotImplemented
      end

      # @macro raise_not_implemented
      def repository
        raise Vedeu::Error::NotImplemented
      end

      # @return [Vedeu::Colours::Validator]
      def validator
        @validator ||= Vedeu::Colours::Validator.new(colour)
      end

    end # Translator

  end # Colours

end # Vedeu
