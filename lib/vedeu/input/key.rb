# frozen_string_literal: true

module Vedeu

  module Input

    # A single keypress or combination of keypresses bound to a
    # specific action.
    #
    # @api private
    #
    class Key

      # @!attribute [r] input
      # @return [String|Symbol] Returns the key defined.
      attr_reader :input
      alias key input

      # Returns a new instance of Vedeu::Input::Key.
      #
      # @param input [String|Symbol]
      # @macro param_block
      # @macro raise_requires_block
      # @return [Vedeu::Input::Key]
      def initialize(input = nil, &block)
        raise Vedeu::Error::RequiresBlock unless block_given?

        @input  = input
        @output = block
      end

      # Pressing the key will call the procedure.
      #
      # @return [|Symbol]
      def output
        @output.call
      end
      alias action output
      alias press output

    end # Key

  end # Input

end # Vedeu
