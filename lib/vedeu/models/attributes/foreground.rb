module Vedeu
  class Foreground < ColourTranslator

    private

    def named
      ["\e[", foreground_codes[colour], "m"].join
    end

    def numbered
      ["\e[38;5;", css_to_numbered, "m"].join
    end

    def rgb
      if Terminal.colour_mode == 16777216
        sprintf("\e[38;2;%s;%s;%sm", *css_to_rgb)

      else
        numbered

      end
    end

    def foreground_codes
      codes
    end

  end
end
