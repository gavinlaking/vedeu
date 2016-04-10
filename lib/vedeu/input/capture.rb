# frozen_string_literal: true

module Vedeu

  # Produces ASCII character 27 which is ESC
  ESCAPE_KEY_CODE = 27

  module Input

    # Captures input from the user terminal via 'getch' and
    # translates special characters into symbols.
    #
    # @api private
    #
    class Capture

      include Vedeu::Common
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
        Vedeu.log(type: :input, message: "Waiting for user input...\n")

        if raw_mode?
          Vedeu.trigger(:_keypress_, keypress)

        elsif fake_mode?
          @key ||= keypress

          if @key.nil?
            nil

          elsif click?(@key)
            Vedeu.trigger(:_mouse_event_, @key)

          elsif Vedeu::Input::Mapper.registered?(@key, name)
            Vedeu.trigger(:_keypress_, @key, name)

          elsif interface.editable?
            Vedeu.trigger(:_editor_, @key)

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
        keys = Vedeu::Input::Raw.read

        if click?(keys)
          Vedeu::Input::Mouse.click(keys)

        else
          keys

        end
      end

      # @macro interface_by_name
      def interface
        Vedeu.interfaces.by_name(name)
      end

      # Returns a boolean indicating whether a mouse click was
      # received.
      #
      # @param keys [NilClass|String|Symbol|Vedeu::Cursors::Cursor]
      # @return [Boolean]
      def click?(keys)
        return false if keys.nil? || symbol?(keys)

        keys.is_a?(Vedeu::Cursors::Cursor) || keys.start_with?("\e[M")
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

      # @macro return_name
      def name
        Vedeu.focus
      end

    end # Input

  end # Input

end # Vedeu
