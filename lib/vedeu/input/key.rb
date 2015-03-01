module Vedeu

  # A single keypress or combination of keypresses bound to a specific action.
  #
  class Key

    # Returns a new instance of Key.
    #
    # @param input [String|Symbol]
    # @param block [Proc]
    # @raise [InvalidSyntax] The required block was not given.
    # @return [Key]
    def initialize(input = nil, &block)
      fail InvalidSyntax, 'block not given' unless block_given?

      @input  = input
      @output = block
    end

    # Returns the key defined.
    #
    # @return [String|Symbol]
    def input
      @input
    end
    alias_method :key, :input

    # Pressing the key will call the procedure.
    #
    # @return [|Symbol]
    def output
      @output.call
    end
    alias_method :action, :output
    alias_method :press, :output

  end # Key

end # Vedeu
