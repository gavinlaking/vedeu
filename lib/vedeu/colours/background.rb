module Vedeu

  # The class represents one half (the other, can be found at
  # {Vedeu::Foreground}) of a terminal colour escape sequence.
  #
  # @api private
  class Background < Vedeu::ColourTranslator

    private

    # @return [String]
    def named_codes
      Vedeu::Esc.background_codes[colour]
    end

    # @return [String]
    def numbered_prefix
      "\e[48;5;"
    end

    # @return [Vedeu::Backgrounds]
    def repository
      Vedeu.background_colours
    end

    # @return [String]
    def rgb_prefix
      "\e[48;2;%s;%s;%sm"
    end

  end # Background

end # Vedeu
