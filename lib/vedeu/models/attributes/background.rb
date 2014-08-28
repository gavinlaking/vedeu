module Vedeu
  class Background < ColourTranslator

    private

    # @return [String]
    def named
      ["\e[", background_codes[colour], "m"].join
    end

    # @return [String]
    def numbered
      ["\e[48;5;", css_to_numbered, "m"].join
    end

    # @return [String]
    def rgb
      if Terminal.colour_mode == 16777216
        sprintf("\e[48;2;%s;%s;%sm", *css_to_rgb)

      else
        numbered

      end
    end

    # @return [Hash]
    def background_codes
      codes.inject({}){ |h, (k, v)| h.merge(k => v + 10) }
    end

  end
end
