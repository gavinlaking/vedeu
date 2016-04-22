# frozen_string_literal: true

module Vedeu

  module EscapeSequences

    # Provides foreground colour related escape sequences.
    #
    # @api public
    # See {file:docs/dsl/by_method/esc.md}
    module Foreground

      extend Forwardable
      extend self

      def_delegators Vedeu::EscapeSequences::Actions, :fg_reset

      # @macro param_block
      # @return [String]
      def black(&block)
        foreground("\e[30m", &block)
      end

      # @macro param_block
      # @return [String]
      def red(&block)
        foreground("\e[31m", &block)
      end

      # @macro param_block
      # @return [String]
      def green(&block)
        foreground("\e[32m", &block)
      end

      # @macro param_block
      # @return [String]
      def yellow(&block)
        foreground("\e[33m", &block)
      end

      # @macro param_block
      # @return [String]
      def blue(&block)
        foreground("\e[34m", &block)
      end

      # @macro param_block
      # @return [String]
      def magenta(&block)
        foreground("\e[35m", &block)
      end

      # @macro param_block
      # @return [String]
      def cyan(&block)
        foreground("\e[36m", &block)
      end

      # @macro param_block
      # @return [String]
      def light_grey(&block)
        foreground("\e[37m", &block)
      end

      # @macro param_block
      # @return [String]
      def default(&block)
        foreground("\e[39m", &block)
      end

      # @macro param_block
      # @return [String]
      def dark_grey(&block)
        foreground("\e[90m", &block)
      end

      # @macro param_block
      # @return [String]
      def light_red(&block)
        foreground("\e[91m", &block)
      end

      # @macro param_block
      # @return [String]
      def light_green(&block)
        foreground("\e[92m", &block)
      end

      # @macro param_block
      # @return [String]
      def light_yellow(&block)
        foreground("\e[93m", &block)
      end

      # @macro param_block
      # @return [String]
      def light_blue(&block)
        foreground("\e[94m", &block)
      end

      # @macro param_block
      # @return [String]
      def light_magenta(&block)
        foreground("\e[95m", &block)
      end

      # @macro param_block
      # @return [String]
      def light_cyan(&block)
        foreground("\e[96m", &block)
      end

      # @macro param_block
      # @return [String]
      def white(&block)
        foreground("\e[97m", &block)
      end

      private

      # @param sequence [String] The colour escape sequence.
      # @macro param_block
      # @return [String]
      def foreground(sequence, &block)
        if block_given?
          sequence + yield + fg_reset

        else
          sequence

        end
      end

    end # Foreground

  end # EscapeSequences

end # Vedeu
