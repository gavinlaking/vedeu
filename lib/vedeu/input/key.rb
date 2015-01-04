require 'vedeu/support/common'

module Vedeu

  #
  # A single keypress or combination of keypresses bound to a specific action.
  #
  class Key

    include Vedeu::Common

    class << self

      include Vedeu::Common

      # Creates a new instance of Key.
      #
      # @see Vedeu::Key#initialize
      def define(input = nil, &block)
        return requires_block(__callee__) unless block_given?

        new(input, &block)
      end

    end

    # Returns a new instance of Key.
    #
    # @param input [String|Symbol]
    # @param output [Proc]
    # @return [Key]
    def initialize(input = nil, &block)
      return requires_block(__callee__) unless block_given?

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
