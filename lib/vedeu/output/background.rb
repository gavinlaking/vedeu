module Vedeu

  # The class represents one half (the other, can be found at
  # {Vedeu::Foreground}) of a terminal colour escape sequence.
  #
  # @api private
  #
  class Background < Translator

    private

    # Returns an escape sequence for a named background colour.
    #
    # Valid names are: `:black`, `:red`, `:green`, `:yellow`, `:blue`,
    # `:magenta`, `:cyan`, `:white` and `:default`.
    #
    # @return [String]
    def named
      ["\e[", Esc.background_codes[colour], 'm'].join
    end

    # Returns an escape sequence.
    #
    # @return [String]
    def numbered
      ["\e[48;5;", css_to_numbered, 'm'].join
    end

    # Returns an escape sequence.
    #
    # @return [String]
    def rgb
      if Configuration.colour_mode == 16777216
        sprintf("\e[48;2;%s;%s;%sm", *css_to_rgb)

      else
        numbered

      end
    end

  end # Background

end # Vedeu
