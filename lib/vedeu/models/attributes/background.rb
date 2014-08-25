module Vedeu
  class Background < ColourTranslator

    private

    def named
      ["\e[", background_codes[colour], "m"].join
    end

    def numbered
      ["\e[48;5;", css_to_numbered, "m"].join
    end

    def rgb
      if Terminal.colour_mode == 16777216
        sprintf("\e[48;2;%s;%s;%sm", *css_to_rgb)

      else
        numbered

      end
    end

    def background_codes
      hash = {}
      codes.map { |name, code| hash[name] = code + 10 }
      hash
    end

  end
end
