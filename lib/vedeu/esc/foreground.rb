module Vedeu

  module EscapeSequences

    # Provides foreground colour related escape sequences.
    #
    module Foreground

      extend self

      # @param block [Proc]
      # @return [String]
      def black(&block)
        if block_given?
          "\e[30m".freeze + yield + "\e[39m".freeze

        else
          "\e[30m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def red(&block)
        if block_given?
          "\e[31m".freeze + yield + "\e[39m".freeze

        else
          "\e[31m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def green(&block)
        if block_given?
          "\e[32m".freeze + yield + "\e[39m".freeze

        else
          "\e[32m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def yellow(&block)
        if block_given?
          "\e[33m".freeze + yield + "\e[39m".freeze

        else
          "\e[33m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def blue(&block)
        if block_given?
          "\e[34m".freeze + yield + "\e[39m".freeze

        else
          "\e[34m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def magenta(&block)
        if block_given?
          "\e[35m".freeze + yield + "\e[39m".freeze

        else
          "\e[35m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def cyan(&block)
        if block_given?
          "\e[36m".freeze + yield + "\e[39m".freeze

        else
          "\e[36m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def light_grey(&block)
        if block_given?
          "\e[37m".freeze + yield + "\e[39m".freeze

        else
          "\e[37m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def default(&block)
        if block_given?
          "\e[39m".freeze + yield + "\e[39m".freeze

        else
          "\e[39m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def dark_grey(&block)
        if block_given?
          "\e[90m".freeze + yield + "\e[39m".freeze

        else
          "\e[90m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def light_red(&block)
        if block_given?
          "\e[91m".freeze + yield + "\e[39m".freeze

        else
          "\e[91m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def light_green(&block)
        if block_given?
          "\e[92m".freeze + yield + "\e[39m".freeze

        else
          "\e[92m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def light_yellow(&block)
        if block_given?
          "\e[93m".freeze + yield + "\e[39m".freeze

        else
          "\e[93m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def light_blue(&block)
        if block_given?
          "\e[94m".freeze + yield + "\e[39m".freeze

        else
          "\e[94m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def light_magenta(&block)
        if block_given?
          "\e[95m".freeze + yield + "\e[39m".freeze

        else
          "\e[95m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def light_cyan(&block)
        if block_given?
          "\e[96m".freeze + yield + "\e[39m".freeze

        else
          "\e[96m".freeze

        end
      end

      # @param block [Proc]
      # @return [String]
      def white(&block)
        if block_given?
          "\e[97m".freeze + yield + "\e[39m".freeze

        else
          "\e[97m".freeze

        end
      end

    end # Foreground

  end # EscapeSequences

end # Vedeu
