module Vedeu

  # Captures input from the user via {Vedeu::Terminal#input} and translates
  # special characters into symbols.
  #
  class Input

    # Instantiate Input and capture keypress(es).
    #
    # @param (see #initialize)
    # @return [String|Symbol]
    def self.capture(reader)
      new(reader).capture
    end

    # Returns a new instance of Vedeu::Input.
    #
    # @param reader [IO] An object that responds to `#read`. Typically, this is
    #   Vedeu::Terminal.
    # @return [Vedeu::Input]
    def initialize(reader)
      @reader = reader
    end

    # Triggers either a ':_command_' event with the command when the reader is
    # in cooked mode, or when in raw mode, the keypress event with the key(s)
    # pressed.
    #
    # @return [Array|String|Symbol]
    def capture
      if reader.raw_mode?
        Vedeu.trigger(:_keypress_, keypress)

      elsif reader.fake_mode?
        Vedeu.trigger(:_editor_, keypress)

      else
        Vedeu.trigger(:_command_, command)

      end
    end

    protected

    # @!attribute [r] reader
    # @return [IO]
    attr_reader :reader

    private

    # Returns the translated (when possible) keypress(es) as either a String or
    # a Symbol.
    #
    # @return [String|Symbol]
    def keypress
      key = input

      Vedeu::InputTranslator.translate(key)
    end

    # Returns the input from the terminal.
    #
    # @return [String]
    def input
      @input ||= reader.read
    end
    alias_method :command, :input

  end # Input

end # Vedeu
