module Vedeu

  module Input

    # Captures input from the user via {Vedeu::Terminal#input} and
    # translates special characters into symbols.
    #
    class Capture

      # Instantiate Vedeu::Input::Input and capture keypress(es).
      #
      # @param (see #initialize)
      # @return (see #read)
      def self.read(reader)
        new(reader).read
      end

      # Returns a new instance of Vedeu::Input::Input.
      #
      # @param reader [IO] An object that responds to `#read`.
      #   Typically, this is Vedeu::Terminal.
      # @return [Vedeu::Input::Input]
      def initialize(reader)
        @reader = reader
      end

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
        if reader.raw_mode?
          Vedeu.trigger(:_keypress_, keypress)

        elsif reader.fake_mode?
          name      = Vedeu.focus
          interface = Vedeu.interfaces.by_name(name)
          key       = keypress

          if Vedeu::Input::Mapper.registered?(key, name)
            Vedeu.trigger(:_keypress_, key, name)

          elsif interface.editable?
            Vedeu.trigger(:_editor_, key)

          else
            Vedeu.trigger(:key, key)

          end
        else
          Vedeu.trigger(:_command_, command)

        end
      end

      protected

      # @!attribute [r] reader
      # @return [IO]
      attr_reader :reader

      private

      # Returns the translated (when possible) keypress(es).
      #
      # @return [String|Symbol]
      def keypress
        key = input

        Vedeu::Input::Translator.translate(key)
      end

      # Returns the input from the terminal.
      #
      # @return [String]
      def input
        @input ||= reader.read
      end
      alias_method :command, :input

    end # Input

  end # Input

end # Vedeu
