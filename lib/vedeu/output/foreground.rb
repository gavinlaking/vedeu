require 'vedeu/configuration/configuration'
require 'vedeu/output/translator'
require 'vedeu/output/esc'

module Vedeu

  # The class represents one half (the other, can be found at
  # {Vedeu::Background}) of a terminal colour escape sequence.
  class Foreground < Vedeu::Translator

    private

    # Registers a HTML/CSS colour code and escape sequence to reduce processing.
    #
    # @param colour [String] A HTML/CSS colour code.
    # @param escape_sequence [String] The HTML/CSS colour code as an escape
    #   sequence.
    # @return [String]
    def register(colour, escape_sequence)
      Vedeu.foreground_colours.register(colour, escape_sequence)
    end

    # Returns a boolean indicating the HTML/CSS colour code has been registered.
    #
    # @param colour [String]
    # @return [Boolean]
    def registered?(colour)
      Vedeu.foreground_colours.registered?(colour)
    end

    # Retrieves the escape sequence for the HTML/CSS colour code.
    #
    # @param colour [String]
    # @return [String]
    def retrieve(colour)
      Vedeu.foreground_colours.retrieve(colour)
    end

    # @return [String]
    def named_codes
      Vedeu::Esc.foreground_codes[colour]
    end

    # @return [String]
    def numbered_prefix
      "\e[38;5;"
    end

    # @return [String]
    def rgb_prefix
      "\e[38;2;%s;%s;%sm"
    end

  end # Foreground

end # Vedeu
