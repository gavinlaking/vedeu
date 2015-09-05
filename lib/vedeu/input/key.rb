module Vedeu

  # A single keypress or combination of keypresses bound to a specific action.
  #
  class Key

    # @!attribute [r] input
    # @return [String|Symbol] Returns the key defined.
    attr_reader :input
    alias_method :key, :input

    # Returns a new instance of Vedeu::Key.
    #
    # @param input [String|Symbol]
    # @param block [Proc]
    # @raise [Vedeu::Error::InvalidSyntax] The required block was not given.
    # @return [Vedeu::Key]
    def initialize(input = nil, &block)
      fail Vedeu::Error::InvalidSyntax, 'block not given' unless block_given?

      @input  = input
      @output = block
    end

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
