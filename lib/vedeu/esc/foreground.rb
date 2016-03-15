# frozen_string_literal: true

module Vedeu

  module EscapeSequences

    # Provides foreground colour related escape sequences.
    #
    # @api public
    # See {file:docs/dsl/by_method/esc.md}
    module Foreground

      extend self

      # @macro param_block
      # @return [String]
      def black(&block)
        if block_given?
          "\e[30m" + yield + "\e[39m"

        else
          "\e[30m"

        end
      end

      # @macro param_block
      # @return [String]
      def red(&block)
        if block_given?
          "\e[31m" + yield + "\e[39m"

        else
          "\e[31m"

        end
      end

      # @macro param_block
      # @return [String]
      def green(&block)
        if block_given?
          "\e[32m" + yield + "\e[39m"

        else
          "\e[32m"

        end
      end

      # @macro param_block
      # @return [String]
      def yellow(&block)
        if block_given?
          "\e[33m" + yield + "\e[39m"

        else
          "\e[33m"

        end
      end

      # @macro param_block
      # @return [String]
      def blue(&block)
        if block_given?
          "\e[34m" + yield + "\e[39m"

        else
          "\e[34m"

        end
      end

      # @macro param_block
      # @return [String]
      def magenta(&block)
        if block_given?
          "\e[35m" + yield + "\e[39m"

        else
          "\e[35m"

        end
      end

      # @macro param_block
      # @return [String]
      def cyan(&block)
        if block_given?
          "\e[36m" + yield + "\e[39m"

        else
          "\e[36m"

        end
      end

      # @macro param_block
      # @return [String]
      def light_grey(&block)
        if block_given?
          "\e[37m" + yield + "\e[39m"

        else
          "\e[37m"

        end
      end

      # @macro param_block
      # @return [String]
      def default(&block)
        if block_given?
          "\e[39m" + yield + "\e[39m"

        else
          "\e[39m"

        end
      end

      # @macro param_block
      # @return [String]
      def dark_grey(&block)
        if block_given?
          "\e[90m" + yield + "\e[39m"

        else
          "\e[90m"

        end
      end

      # @macro param_block
      # @return [String]
      def light_red(&block)
        if block_given?
          "\e[91m" + yield + "\e[39m"

        else
          "\e[91m"

        end
      end

      # @macro param_block
      # @return [String]
      def light_green(&block)
        if block_given?
          "\e[92m" + yield + "\e[39m"

        else
          "\e[92m"

        end
      end

      # @macro param_block
      # @return [String]
      def light_yellow(&block)
        if block_given?
          "\e[93m" + yield + "\e[39m"

        else
          "\e[93m"

        end
      end

      # @macro param_block
      # @return [String]
      def light_blue(&block)
        if block_given?
          "\e[94m" + yield + "\e[39m"

        else
          "\e[94m"

        end
      end

      # @macro param_block
      # @return [String]
      def light_magenta(&block)
        if block_given?
          "\e[95m" + yield + "\e[39m"

        else
          "\e[95m"

        end
      end

      # @macro param_block
      # @return [String]
      def light_cyan(&block)
        if block_given?
          "\e[96m" + yield + "\e[39m"

        else
          "\e[96m"

        end
      end

      # @macro param_block
      # @return [String]
      def white(&block)
        if block_given?
          "\e[97m" + yield + "\e[39m"

        else
          "\e[97m"

        end
      end

    end # Foreground

  end # EscapeSequences

end # Vedeu
