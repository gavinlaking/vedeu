# frozen_string_literal: true

module Vedeu

  module EscapeSequences

    # Provides background colour related escape sequences.
    #
    # @api public
    # See {file:docs/dsl/by_method/esc.md}
    module Background

      extend self

      # @macro param_block
      # @return [String]
      def on_black(&block)
        if block_given?
          "\e[40m" + yield + "\e[49m"

        else
          "\e[40m"

        end
      end

      # @macro param_block
      # @return [String]
      def on_red(&block)
        if block_given?
          "\e[41m" + yield + "\e[49m"

        else
          "\e[41m"

        end
      end

      # @macro param_block
      # @return [String]
      def on_green(&block)
        if block_given?
          "\e[42m" + yield + "\e[49m"

        else
          "\e[42m"

        end
      end

      # @macro param_block
      # @return [String]
      def on_yellow(&block)
        if block_given?
          "\e[43m" + yield + "\e[49m"

        else
          "\e[43m"

        end
      end

      # @macro param_block
      # @return [String]
      def on_blue(&block)
        if block_given?
          "\e[44m" + yield + "\e[49m"

        else
          "\e[44m"

        end
      end

      # @macro param_block
      # @return [String]
      def on_magenta(&block)
        if block_given?
          "\e[45m" + yield + "\e[49m"

        else
          "\e[45m"

        end
      end

      # @macro param_block
      # @return [String]
      def on_cyan(&block)
        if block_given?
          "\e[46m" + yield + "\e[49m"

        else
          "\e[46m"

        end
      end

      # @macro param_block
      # @return [String]
      def on_light_grey(&block)
        if block_given?
          "\e[47m" + yield + "\e[49m"

        else
          "\e[47m"

        end
      end

      # @macro param_block
      # @return [String]
      def on_default(&block)
        if block_given?
          "\e[49m" + yield + "\e[49m"

        else
          "\e[49m"

        end
      end

      # @macro param_block
      # @return [String]
      def on_dark_grey(&block)
        if block_given?
          "\e[100m" + yield + "\e[49m"

        else
          "\e[100m"

        end
      end

      # @macro param_block
      # @return [String]
      def on_light_red(&block)
        if block_given?
          "\e[101m" + yield + "\e[49m"

        else
          "\e[101m"

        end
      end

      # @macro param_block
      # @return [String]
      def on_light_green(&block)
        if block_given?
          "\e[102m" + yield + "\e[49m"

        else
          "\e[102m"

        end
      end

      # @macro param_block
      # @return [String]
      def on_light_yellow(&block)
        if block_given?
          "\e[103m" + yield + "\e[49m"

        else
          "\e[103m"

        end
      end

      # @macro param_block
      # @return [String]
      def on_light_blue(&block)
        if block_given?
          "\e[104m" + yield + "\e[49m"

        else
          "\e[104m"

        end
      end

      # @macro param_block
      # @return [String]
      def on_light_magenta(&block)
        if block_given?
          "\e[105m" + yield + "\e[49m"

        else
          "\e[105m"

        end
      end

      # @macro param_block
      # @return [String]
      def on_light_cyan(&block)
        if block_given?
          "\e[106m" + yield + "\e[49m"

        else
          "\e[106m"

        end
      end

      # @macro param_block
      # @return [String]
      def on_white(&block)
        if block_given?
          "\e[107m" + yield + "\e[49m"

        else
          "\e[107m"

        end
      end

    end # Background

  end # EscapeSequences

end # Vedeu
