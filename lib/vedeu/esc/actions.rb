# frozen_string_literal: true

module Vedeu

  module EscapeSequences

    # Provides action related escape sequences.
    #
    # @api public
    #
    module Actions

      extend self

      # @return [String]
      def bg_reset
        "\e[49m"
      end

      # @return [String]
      def blink
        "\e[5m"
      end

      # @return [String]
      def blink_off
        "\e[25m"
      end

      # @return [String]
      def bold
        "\e[1m"
      end

      # @return [String]
      def bold_off
        "\e[22m"
      end

      # @return [String]
      def cursor_position
        "\e[6n"
      end

      # @return [String]
      def dim
        "\e[2m"
      end

      # @return [String]
      def fg_reset
        "\e[39m"
      end

      # @return [String]
      def hide_cursor
        "\e[?25l"
      end

      # @return [String]
      def negative
        "\e[7m"
      end

      # @return [String]
      def positive
        "\e[27m"
      end

      # @return [String]
      def reset
        "\e[0m"
      end

      # @return [String]
      def show_cursor
        "\e[?25h"
      end

      # @return [String]
      def underline
        "\e[4m"
      end

      # @return [String]
      def underline_off
        "\e[24m"
      end

    end # Actions

  end # EscapeSequences

end # Vedeu
