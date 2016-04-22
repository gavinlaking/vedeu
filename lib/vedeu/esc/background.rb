# frozen_string_literal: true

module Vedeu

  module EscapeSequences

    # Provides background colour related escape sequences.
    #
    # @api public
    # See {file:docs/dsl/by_method/esc.md}
    module Background

      extend Forwardable
      extend self

      def_delegators Vedeu::EscapeSequences::Actions, :bg_reset

      # @macro param_block
      # @return [String]
      def on_black(&block)
        background("\e[40m", &block)
      end

      # @macro param_block
      # @return [String]
      def on_red(&block)
        background("\e[41m", &block)
      end

      # @macro param_block
      # @return [String]
      def on_green(&block)
        background("\e[42m", &block)
      end

      # @macro param_block
      # @return [String]
      def on_yellow(&block)
        background("\e[43m", &block)
      end

      # @macro param_block
      # @return [String]
      def on_blue(&block)
        background("\e[44m", &block)
      end

      # @macro param_block
      # @return [String]
      def on_magenta(&block)
        background("\e[45m", &block)
      end

      # @macro param_block
      # @return [String]
      def on_cyan(&block)
        background("\e[46m", &block)
      end

      # @macro param_block
      # @return [String]
      def on_light_grey(&block)
        background("\e[47m", &block)
      end

      # @macro param_block
      # @return [String]
      def on_default(&block)
        background(bg_reset, &block)
      end

      # @macro param_block
      # @return [String]
      def on_dark_grey(&block)
        background("\e[100m", &block)
      end

      # @macro param_block
      # @return [String]
      def on_light_red(&block)
        background("\e[101m", &block)
      end

      # @macro param_block
      # @return [String]
      def on_light_green(&block)
        background("\e[102m", &block)
      end

      # @macro param_block
      # @return [String]
      def on_light_yellow(&block)
        background("\e[103m", &block)
      end

      # @macro param_block
      # @return [String]
      def on_light_blue(&block)
        background("\e[104m", &block)
      end

      # @macro param_block
      # @return [String]
      def on_light_magenta(&block)
        background("\e[105m", &block)
      end

      # @macro param_block
      # @return [String]
      def on_light_cyan(&block)
        background("\e[106m", &block)
      end

      # @macro param_block
      # @return [String]
      def on_white(&block)
        background("\e[107m", &block)
      end

      private

      # @param sequence [String] The colour escape sequence.
      # @macro param_block
      # @return [String]
      def background(sequence, &block)
        if block_given?
          sequence + yield + bg_reset

        else
          sequence

        end
      end

    end # Background

  end # EscapeSequences

end # Vedeu
