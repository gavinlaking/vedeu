module Vedeu

  module EscapeSequences

    # Provides action related escape sequences.
    #
    module Actions

      extend self

      # @return [Hash<Symbol => String>]
      def characters
        {
          hide_cursor:     "\e[?25l".freeze,
          show_cursor:     "\e[?25h".freeze,
          cursor_position: "\e[6n".freeze,
          bg_reset:        "\e[49m".freeze,
          blink:           "\e[5m".freeze,
          blink_off:       "\e[25m".freeze,
          bold:            "\e[1m".freeze,
          bold_off:        "\e[22m".freeze,
          dim:             "\e[2m".freeze,
          fg_reset:        "\e[39m".freeze,
          negative:        "\e[7m".freeze,
          positive:        "\e[27m".freeze,
          reset:           "\e[0m".freeze,
          underline:       "\e[4m".freeze,
          underline_off:   "\e[24m".freeze,
        }
      end

      # @return [void]
      def setup!
        characters.each { |key, code| define_method(key) { code } }
      end

    end # Actions

  end # EscapeSequences

  Vedeu::EscapeSequences::Actions.setup!

end # Vedeu
