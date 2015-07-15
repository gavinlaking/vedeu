module Vedeu

  # Namespace for the API configuration and CLI configuration classes.
  module Config

    module_function

    # Custom log for configuration.
    #
    # @param from [String] Which configuration set the options ('API' or 'CLI').
    # @param options [Hash] The configuration options set.
    # @return [Hash] The options param.
    def log(from, options)
      options.each do |option, value|
        Vedeu.log(type:    :config,
                  message: "#{from} #{option}: #{value}")
      end
    end

  end

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

      # Returns the base_path value
      #
      # @return [String]
      def base_path
        instance.options[:base_path]
      end

      # Configure Vedeu with sensible defaults. If the client application sets
      # options, override the defaults with those, and if command-line arguments
      # are provided at application invocation, override any options with the
      # arguments provided.
      #
      # @example
      #   Vedeu.configure
      #     # ...
      #   end
      #
      # @param args [Array]
      # @param opts [Hash]
      # @option opts stdin [File|IO]
      # @option opts stdout [File|IO]
      # @option opts stderr [File|IO]
      # @param block [Proc]
      # @raise [InvalidSyntax] When the required block is not given.
      # @return [Hash]
      def configure(args = [], opts = {}, &block)
        instance.configure(args, opts, &block)
      end

      # Returns the configuration singleton.
      #
      # @example
      #   Vedeu.configuration
      #     # ...
      #   end
      #
      # @return [Vedeu::Configuration]
      def configuration
        instance
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

      # Returns whether the DRb server is enabled or disabled. Default is false.
      #
      # @return [Boolean]
      def drb?
        instance.options[:drb]
      end
      alias_method :drb, :drb?

      # Returns the hostname for the DRb server.
      #
      # @return [String]
      def drb_host
        instance.options[:drb_host]
      end

      # Returns the port for the DRb server.
      #
      # @return [String]
      def drb_port
        instance.options[:drb_port]
      end

      # Returns the height for the fake terminal in the DRb server.
      #
      # @return [Fixnum]
      def drb_height
        instance.options[:drb_height]
      end

      # Returns the width for the fake terminal in the DRb server.
      #
      # @return [Fixnum]
      def drb_width
        instance.options[:drb_width]
      end

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

      # Returns a boolean indicating whether the log has been configured.
      #
      # @return [Boolean]
      def log?
        log != nil
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

      # Returns the renderers which should receive output.
      #
      # @return [Array<Class>]
      def renderers
        instance.options[:renderers]
      end

      # Returns the redefined setting for STDIN.
      #
      # @return [File|IO]
      def stdin
        instance.options[:stdin]
      end

      # Returns the redefined setting for STDOUT.
      #
      # @return [File|IO]
      def stdout
        instance.options[:stdout]
      end

      # Returns the redefined setting for STDERR.
      #
      # @return [File|IO]
      def stderr
        instance.options[:stderr]
      end

      # Returns the terminal mode for the application. Default is `:raw`.
      #
      # @return [Symbol]
      def terminal_mode
        instance.options[:terminal_mode]
      end

      # @param value [void]
      # @return [void]
      def options=(value)
        instance.options = value
      end

      # Reset the configuration to the default values.
      #
      # @return [Hash]
      def reset!
        instance.reset!
      end

    end # Eigenclass

    # @!attribute [r] options
    # @return [Hash]
    attr_reader :options

    # Create a new singleton instance of Vedeu::Configuration.
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
    def configure(args = [], opts = {}, &block)
      @options.merge!(opts)

      @options.merge!(Config::API.configure(&block)) if block_given?
      @options.merge!(Config::CLI.configure(args)) if args.any?

      Vedeu::Renderers.renderer(*@options[:renderers])

      Vedeu::Configuration
    end

    # Reset the configuration to the default values.
    #
    # @return [Hash]
    def reset!
      @options = defaults
    end

    private

    # The Vedeu default options, which of course are influenced by environment
    # variables also.
    #
    # @return [Hash]
    def defaults
      {
        base_path:     base_path,
        colour_mode:   detect_colour_mode,
        debug:         false,
        drb:           false,
        drb_host:      nil,
        drb_port:      nil,
        drb_height:    25,
        drb_width:     80,
        interactive:   true,
        log:           nil,
        once:          false,
        renderers:     [Vedeu::Renderers::Terminal.new],
        stdin:         nil,
        stdout:        nil,
        stderr:        nil,
        terminal_mode: :raw,
      }
    end

    # Attempt to determine the terminal colour mode via $TERM environment
    # variable, or be optimistic and settle for 256 colours.
    #
    # @return [Fixnum]
    def detect_colour_mode
      case ENV['TERM']
      when /-truecolor$/         then 16_777_216
      when /-256color$/, 'xterm' then 256
      when /-color$/, 'rxvt'     then 16
      else 256
      end
    end

    # @return [String]
    def base_path
      File.expand_path('.')
    end

  end # Configuration

end # Vedeu
