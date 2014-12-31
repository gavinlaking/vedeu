module Vedeu

  # Allows the customisation of Vedeu's behaviour through the configuration API
  # or command-line arguments.
  #
  # Provides access to Vedeu's configuration, which was set with sensible
  # defaults (influenced by environment variables), overridden by client
  # application settings (via the configuration API), or any command-line
  # arguments provided.
  #
  # @api private
  class Configuration

    include Singleton

    class << self

      # Configure Vedeu with sensible defaults. If the client application sets
      # options, override the defaults with those, and if command-line arguments
      # are provided at application invocation, override any options with the
      # arguments provided.
      #
      # @param args [Array]
      # @param block [Proc]
      # @raise [InvalidSyntax] When the required block is not given.
      # @return [Hash]
      def configure(args = [], &block)
        instance.configure(args, &block)
      end

      # Returns the chosen colour mode.
      #
      # @return [Fixnum]
      def colour_mode
        instance.options[:colour_mode]
      end

      # Returns whether debugging is enabled or disabled. Default is false;
      # meaning nothing apart from warnings are written to the log file.
      #
      # @return [Boolean]
      def debug?
        instance.options[:debug]
      end
      alias_method :debug, :debug?

      # Returns whether the application is interactive (required user input) or
      # standalone (will run until terminates of natural causes.) Default is
      # true; meaning the application will require user input.
      #
      # @return [Boolean]
      def interactive?
        instance.options[:interactive]
      end
      alias_method :interactive, :interactive?

      # Returns the path to the log file.
      #
      # @return [String]
      def log
        instance.options[:log]
      end

      # Returns whether the application will run through its main loop once or
      # not. Default is false; meaning the application will loop forever or
      # until terminated by the user.
      #
      # @return [Boolean]
      def once?
        instance.options[:once]
      end
      alias_method :once, :once?

      # Returns
      #
      # @return [Hash]
      def system_keys
        instance.options[:system_keys]
      end

      # Returns the terminal mode for the application. Default is `:raw`.
      #
      # @return [Symbol]
      def terminal_mode
        instance.options[:terminal_mode]
      end

      # Returns whether tracing is enabled or disabled. Tracing is very noisy in
      # the log file (logging method calls and events trigger). Default is
      # false; meaning tracing is disabled.
      #
      # @return [Boolean]
      def trace?
        instance.options[:trace]
      end
      alias_method :trace, :trace?

      # Vedeu's default system keys. Use {#system_keys}.
      #
      # @return [Hash]
      def default_system_keys
        {
          exit:        'q',
          focus_next:  :tab,
          focus_prev:  :shift_tab,
          mode_switch: :escape,
        }
      end

      def options=(value)
        instance.options = value
      end

      # Reset the configuration to the default values.
      #
      # @return [Hash]
      def reset!
        # Vedeu::Log.logger.debug('Resetting configuration.')

        instance.reset!
      end

    end # Configuration eigenclass

    attr_reader :options

    # Create a new singleton instance of Configuration.
    #
    # @return [Configuration]
    def initialize
      @options = defaults
    end

    # Set up default configuration and then allow the client application to
    # modify it via the configuration API. After this, process any command line
    # arguments as potential configuration and apply that.
    #
    # @param args [Array]
    # @param block [Proc]
    # @return [Hash]
    def configure(args = [], &block)
      @options.merge!(Config::API.configure(&block)) if block_given?

      @options.merge!(Config::CLI.configure(args)) if args.any?

      @options
    end

    # Reset the configuration to the default values.
    #
    # @return [Hash]
    def reset!
      # Vedeu::Log.logger.debug('Resetting configuration.')

      @options = defaults
    end

    private

    # The Vedeu default options, which of course are influenced by environment
    # variables also.
    #
    # @return [Hash]
    def defaults
      {
        colour_mode:   detect_colour_mode,
        debug:         false,
        interactive:   true,
        log:           '/tmp/vedeu.log',
        once:          false,
        system_keys:   Configuration.default_system_keys,
        terminal_mode: :raw,
        trace:         false,
      }
    end

    # Attempt to determine the terminal colour mode via $TERM environment
    # variable, or be optimistic and settle for 256 colours.
    #
    # @return [Fixnum]
    def detect_colour_mode
      case ENV['TERM']
      when /-truecolor$/         then 16777216
      when /-256color$/, 'xterm' then 256
      when /-color$/, 'rxvt'     then 16
      else 256
      end
    end

  end # Configuration

end # Vedeu
