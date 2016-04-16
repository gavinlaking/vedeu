# frozen_string_literal: true

module Vedeu

  module EscapeSequences

    # Provides mouse related escape sequences.
    #
    # The X10 compatibility mode sends an escape sequence on button
    # press encoding the location and the mouse button pressed. It is
    # enabled by sending `\e[?9h` and disabled with `\e[?9l`.
    #
    # On button press, xterm(1) sends `\e[Mbxy` (6 characters).
    # Here b is button-1, and x and y are the x and y coordinates of
    # the mouse when the button was pressed. This is the same code the
    # kernel also produces.
    #
    # Normal tracking mode (not implemented in Linux 2.0.24) sends an
    # escape sequence on both button press and release. Modifier
    # information is also sent. It is enabled by sending `\e[?1000h`
    # and disabled with `\e[?1000l`. On button press or release,
    # xterm(1) sends `\e[Mbxy`. The low two bits of b encode button
    # information: 0=MB1 pressed, 1=MB2 pressed, 2=MB3 pressed,
    # 3=release. The upper bits encode what modifiers were down when
    # the button was pressed and are added together: 4=Shift, 8=Meta,
    # 16=Control. Again x and y are the x and y coordinates of the
    # mouse event. The upper left corner is (1,1).
    #
    # - From CONSOLE_CODES(4) (`man console_codes`)
    #
    # @api public
    #
    module Mouse

      extend self

      # @return [String]
      def disable_mouse
        return mouse_x10_off if Vedeu.config.mouse?

        ''
      end

      # @return [String]
      def enable_mouse
        return mouse_x10_on if Vedeu.config.mouse?

        ''
      end

      # @return [String]
      def mouse_x10_on
        "\e[?9h"
      end

      # @return [String]
      def mouse_x10_off
        "\e[?9l"
      end

      # @return [String]
      def mouse_on
        "\e[?1000h"
      end

      # @return [String]
      def mouse_off
        "\e[?1000l"
      end

    end # Mouse

  end # EscapeSequences

end # Vedeu
