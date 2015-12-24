module Vedeu

  module EscapeSequences

    # Provides action related escape sequences.
    #
    module Actions

      extend self

      # @return [String]
      def bg_reset
        "\e[49m".freeze
      end

      # @return [String]
      def blink
        "\e[5m".freeze
      end

      # @return [String]
      def blink_off
        "\e[25m".freeze
      end

      # @return [String]
      def bold
        "\e[1m".freeze
      end

      # @return [String]
      def bold_off
        "\e[22m".freeze
      end

      # @return [String]
      def cursor_position
        "\e[6n".freeze
      end

      # @return [String]
      def dim
        "\e[2m".freeze
      end

      # @return [String]
      def fg_reset
        "\e[39m".freeze
      end

      # @return [String]
      def hide_cursor
        "\e[?25l".freeze
      end

      # @return [String]
      def negative
        "\e[7m".freeze
      end

      # @return [String]
      def positive
        "\e[27m".freeze
      end

      # @return [String]
      def reset
        "\e[0m".freeze
      end

      # @return [String]
      def show_cursor
        "\e[?25h".freeze
      end

      # @return [String]
      def underline
        "\e[4m".freeze
      end

      # @return [String]
      def underline_off
        "\e[24m".freeze
      end

    end # Actions

  end # EscapeSequences

end # Vedeu
