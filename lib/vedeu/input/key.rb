module Vedeu

  # A single keypress or combination of keypresses bound to a specific action.
  class Key

    # Returns a new instance of Key.
    #
    # @param input [String|Symbol]
    # @param output [Proc]
    # @return [Key]
    def initialize(input, output)
      @input  = input
      @output = output
    end

    # Returns the key defined.
    #
    # @return [String|Symbol]
    def input
      @input
    end
    alias_method :key, :input

    # The procedure to call when the key is pressed.
    #
    # @return []
    def output
      @output
    end
    alias_method :action, :output

    # Pressing the key will call the procedure.
    #
    # @return [|Symbol]
    def press
      output.is_a?(Proc) ? output.call : :noop
    end

  end # Key

end # Vedeu
