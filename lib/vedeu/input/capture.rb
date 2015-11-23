module Vedeu

  ESCAPE_KEY_CODE = 27 # \e

  module Input

    # Captures input from the user terminal via 'getch' and
    # translates special characters into symbols.
    #
    class Capture

      extend Forwardable

      def_delegators Vedeu::Terminal::Mode,
                     :cooked_mode?,
                     :fake_mode?,
                     :raw_mode?

      # Instantiate Vedeu::Input::Input and capture keypress(es).
      #
      # @return (see #read)
      def self.read
        new.read
      end

      # Returns a new instance of Vedeu::Input::Input.
      #
      # @return [Vedeu::Input::Input]
      def initialize; end

      # Triggers various events dependent on the terminal mode.
      #
      # - When in raw mode, the :_keypress_ event is triggered with
      #   the key(s) pressed.
      # - When in fake mode, the keypress will be checked against the
      #   keymap relating to the interface/view currently in focus.
      #   - If registered, the :_keypress_ event is triggered with the
      #     key(s) pressed.
      #   - If the keypress is not registered, we check whether the
      #     interface in focus is editable, if so, the :_editor_
      #     event is triggered.
      #   - Otherwise, the :key event is triggered for the client
      #     application to handle.
      # - When in cooked mode, the :_command_ event is triggered with
      #   the input given.
      #
      # @return [Array|String|Symbol]
      def read
        Vedeu.log(type: :input, message: 'Waiting for user input...'.freeze)

        if raw_mode?
          Vedeu.trigger(:_keypress_, keypress)

        elsif fake_mode?
          @key ||= keypress

          if click?(@key)
            Vedeu.trigger(:_mouse_event_, @key)

          elsif Vedeu::Input::Mapper.registered?(@key, name)
            Vedeu.trigger(:_keypress_, @key, name)

          elsif Vedeu.interfaces.by_name(name).editable?
            Vedeu.trigger(:_editor_, @key)

          elsif @key.nil?
            nil

          else
            Vedeu.trigger(:key, @key)

          end

        elsif cooked_mode?
          Vedeu.trigger(:_command_, command)

        end
      end

      private

      # Returns the translated (when possible) keypress(es).
      #
      # @return [String|Symbol]
      def keypress
        Vedeu::Input::Translator.translate(input)
      end

      # Takes input from the user via the keyboard. Accepts special
      # keys like the F-Keys etc, by capturing the entire sequence.
      #
      # @return [String]
      def input
        keys = console.getch

        if keys.ord == Vedeu::ESCAPE_KEY_CODE
          keys << console.read_nonblock(4) rescue nil
          keys << console.read_nonblock(3) rescue nil
          keys << console.read_nonblock(2) rescue nil
        end

        return Vedeu::Input::Mouse.click(keys) if click?(keys)

        keys
      end

      # Returns a boolean indicating whether a mouse click was
      # received.
      #
      # @param input [NilClass|String|Symbol|Vedeu::Cursors::Cursor]
      # @return [Boolean]
      def click?(input)
        return false if input.nil? || input.is_a?(Symbol)

        input.is_a?(Vedeu::Cursors::Cursor) || input.start_with?("\e[M")
      end

      # @return [IO]
      def console
        @console ||= Vedeu::Terminal.console
      end

      # Takes input from the user via the keyboard. Accepts special
      # keys like the F-Keys etc, by capturing the entire sequence.
      #
      # @return [String]
      def command
        console.gets.chomp
      end

      # @return [String|Symbol]
      def name
        Vedeu.focus
      end

    end # Input

  end # Input

end # Vedeu
