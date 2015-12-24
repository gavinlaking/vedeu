module Vedeu

  module EscapeSequences

    # Provides backgroundcolour related escape sequences.
    #
    module Background

      extend self

      # @param block [Proc]
      # @return [String]
      def on_black(&block)
        if block_given?
          "\e[40m".freeze + yield + "\e[49m".freeze

        else
          "\e[40m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def on_red(&block)
        if block_given?
          "\e[41m".freeze + yield + "\e[49m".freeze

        else
          "\e[41m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def on_green(&block)
        if block_given?
          "\e[42m".freeze + yield + "\e[49m".freeze

        else
          "\e[42m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def on_yellow(&block)
        if block_given?
          "\e[43m".freeze + yield + "\e[49m".freeze

        else
          "\e[43m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def on_blue(&block)
        if block_given?
          "\e[44m".freeze + yield + "\e[49m".freeze

        else
          "\e[44m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def on_magenta(&block)
        if block_given?
          "\e[45m".freeze + yield + "\e[49m".freeze

        else
          "\e[45m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def on_cyan(&block)
        if block_given?
          "\e[46m".freeze + yield + "\e[49m".freeze

        else
          "\e[46m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def on_light_grey(&block)
        if block_given?
          "\e[47m".freeze + yield + "\e[49m".freeze

        else
          "\e[47m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def on_default(&block)
        if block_given?
          "\e[49m".freeze + yield + "\e[49m".freeze

        else
          "\e[49m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def on_dark_grey(&block)
        if block_given?
          "\e[100m".freeze + yield + "\e[49m".freeze

        else
          "\e[100m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def on_light_red(&block)
        if block_given?
          "\e[101m".freeze + yield + "\e[49m".freeze

        else
          "\e[101m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def on_light_green(&block)
        if block_given?
          "\e[102m".freeze + yield + "\e[49m".freeze

        else
          "\e[102m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def on_light_yellow(&block)
        if block_given?
          "\e[103m".freeze + yield + "\e[49m".freeze

        else
          "\e[103m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def on_light_blue(&block)
        if block_given?
          "\e[104m".freeze + yield + "\e[49m".freeze

        else
          "\e[104m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def on_light_magenta(&block)
        if block_given?
          "\e[105m".freeze + yield + "\e[49m".freeze

        else
          "\e[105m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def on_light_cyan(&block)
        if block_given?
          "\e[106m".freeze + yield + "\e[49m".freeze

        else
          "\e[106m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def on_white(&block)
        if block_given?
          "\e[107m".freeze + yield + "\e[49m".freeze

        else
          "\e[107m".freeze

        end
      end

    end # Background

  end # EscapeSequences

end # Vedeu
