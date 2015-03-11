require 'vedeu/configuration/configuration'
require 'vedeu/output/translator'
require 'vedeu/output/esc'

module Vedeu

  # The class represents one half (the other, can be found at
  # {Vedeu::Background}) of a terminal colour escape sequence.
  #
  class Foreground < Vedeu::Translator

    private

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
