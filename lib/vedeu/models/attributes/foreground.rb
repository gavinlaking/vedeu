module Vedeu
  class Foreground < ColourTranslator

    private

    # @return [String]
    def named
      ["\e[", foreground_codes[colour], "m"].join
    end

    # @return [String]
    def numbered
      ["\e[38;5;", css_to_numbered, "m"].join
    end

    # @return [String]
    def rgb
      if Terminal.colour_mode == 16777216
        sprintf("\e[38;2;%s;%s;%sm", *css_to_rgb)

      else
        numbered

      end
    end

    # @return [Hash]
    def foreground_codes
      codes
    end

  end
end
