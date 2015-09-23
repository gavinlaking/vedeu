module Vedeu

  module EscapeSequences

    # Provides action related escape sequences.
    #
    module Actions

      extend self

      # @return [Hash<Symbol => String>]
      def characters
        {
          hide_cursor:     "\e[?25l",
          show_cursor:     "\e[?25h",
          cursor_position: "\e[6n",
          bg_reset:        "\e[49m",
          blink:           "\e[5m",
          blink_off:       "\e[25m",
          bold:            "\e[1m",
          bold_off:        "\e[22m",
          dim:             "\e[2m",
          fg_reset:        "\e[39m",
          negative:        "\e[7m",
          positive:        "\e[27m",
          reset:           "\e[0m",
          underline:       "\e[4m",
          underline_off:   "\e[24m",
        }
      end

      # @return [void]
      def setup!
        define_actions!
      end

      private

      # @return [void]
      def define_actions!
        characters.each { |key, code| define_method(key) { code } }
      end

    end # Actions

  end # EscapeSequences

  Vedeu::EscapeSequences::Actions.setup!

end # Vedeu
