# frozen_string_literal: true

module Vedeu

  # Allows the customisation of Vedeu's behaviour through the
  # configuration API.
  #
  # Provides access to Vedeu's configuration, which was set with
  # sensible defaults (influenced by environment variables),
  # overridden by client application settings (via the configuration
  # API).
  #
  class Configuration

    include Singleton

    class << self

      include Vedeu::Common

      # Return the configured background colour for the client
      # application.
      #
      # @return [String|Symbol]
      def background
        instance.options[:background]
      end

      # Returns the base_path value.
      #
      # @return [String]
      def base_path
        instance.options[:base_path]
      end

      # Returns the compression value.
      #
      # @return [Boolean]
      def compression
        instance.options[:compression]
      end
      alias compression? compression

      # {include:file:docs/dsl/by_method/configure.md}
      # @param opts [Hash<Symbol => void>]
      # @option opts stdin [File|IO]
      # @option opts stdout [File|IO]
      # @option opts stderr [File|IO]
      # @param block [Proc]
      # @return [Hash<Symbol => void>]
      def configure(opts = {}, &block)
        instance.configure(opts, &block)
      end

      # {include:file:docs/dsl/by_method/configuration.md}
      # @return [Vedeu::Configuration]
      def configuration
        self
      end
      alias config configuration

      # @return [Hash]
      def colour
        {
          background: background,
          foreground: foreground,
        }
      end

      # Returns the chosen colour mode.
      #
      # @return [Fixnum]
      def colour_mode
        instance.options[:colour_mode]
      end

      # Returns whether debugging is enabled or disabled. Default is
      # false; meaning only the top line of a backtrace from an
      # exception is shown to the user of the client application.
      #
      # @return [Boolean]
      def debug?
        instance.options[:debug]
      end
      alias debug debug?

      # Returns whether the DRb server is enabled or disabled. Default
      # is false.
      #
      # @return [Boolean]
      def drb?
        instance.options[:drb]
      end
      alias drb drb?

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

      # Return the configured foreground colour for the client
      # application.
      #
      # @return [String|Symbol]
      def foreground
        instance.options[:foreground]
      end

      # Returns the client defined height for the terminal.
      #
      # {include:file:docs/dsl/by_method/height.md}
      #
      # @return [Fixnum]
      def height
        if drb?
          drb_height

        elsif height?
          instance.options[:height]

        else
          Vedeu::Terminal.size[0]

        end
      end

      # @return [Boolean]
      def height?
        instance.options[:height].is_a?(Fixnum)
      end

      # Returns whether the application is interactive (required user
      # input) or standalone (will run until terminates of natural
      # causes.) Default is true; meaning the application will require
      # user input.
      #
      # @return [Boolean]
      def interactive?
        instance.options[:interactive]
      end
      alias interactive interactive?

      # Returns the path to the log file.
      #
      # @return [String]
      def log
        instance.options[:log]
      end

      # Returns a boolean indicating whether the log has been
      # configured; if {#log} contains a path, then this will be true.
      #
      # @return [Boolean]
      def log?
        present?(log)
      end

      # @return [Array<Symbol>]
      def log_except
        instance.options[:log_except] || []
      end

      # @return [Array<Symbol>]
      def log_only
        instance.options[:log_only] || []
      end

      # Returns true if the given type was included in the :log_only
      # configuration option or not included in the :log_except
      # option.
      #
      # @param type [Symbol]
      # @return [Boolean]
      def loggable?(type)
        log_only.include?(type) || !log_except.include?(type)
      end

      # Returns whether mouse support was enabled or disabled.
      #
      # @return [Boolean]
      def mouse?
        instance.options[:mouse]
      end
      alias mouse mouse?

      # Returns whether the application will run through its main loop
      # once or not. Default is false; meaning the application will
      # loop forever or until terminated by the user.
      #
      # @return [Boolean]
      def once?
        instance.options[:once]
      end
      alias once once?

      # Returns a boolean indicating whether profiling has been
      # enabled.
      #
      # @return [Boolean]
      def profile?
        instance.options[:profile]
      end
      alias profile profile?

      # Returns the renderers which should receive output.
      #
      # @return [Array<Class>]
      def renderers
        instance.options[:renderers]
      end

      # Returns the root of the client application. Vedeu will execute
      # this controller first.
      #
      # @return [Class]
      def root
        instance.options[:root]
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

      # Returns the terminal mode for the application. Default is
      # `:raw`.
      #
      # @return [Symbol]
      def terminal_mode
        instance.options[:terminal_mode]
      end

      # Returns the client defined width for the terminal.
      #
      # {include:file:docs/dsl/by_method/width.md}
      #
      # @return [Fixnum]
      def width
        if drb?
          drb_width

        elsif width?
          instance.options[:width]

        else
          Vedeu::Terminal.size[-1]

        end
      end

      # @return [Boolean]
      def width?
        instance.options[:width].is_a?(Fixnum)
      end

      # @param value [void]
      # @return [void]
      def options=(value)
        instance.options = value
      end

      # Reset the configuration to the default values.
      #
      # @return [Hash<Symbol => void>]
      def reset!
        instance.reset!
      end

    end # Eigenclass

    # @!attribute [r] options
    # @return [Hash<Symbol => void>]
    attr_reader :options

    # Create a new singleton instance of Vedeu::Configuration.
    #
    # @return [Vedeu::Configuration]
    def initialize
      @options = defaults
    end

    # Set up default configuration and then allow the client
    # application to modify it via the configuration API.
    #
    # @param block [Proc]
    # @return [Hash<Symbol => void>]
    def configure(opts = {}, &block)
      @options.merge!(opts)

      @options.merge!(Config::API.configure(&block)) if block_given?

      Vedeu::Configuration
    end

    # Reset the configuration to the default values.
    #
    # @return [Hash<Symbol => void>]
    def reset!
      @options = defaults
    end

    private

    # The Vedeu default options, which of course are influenced by
    # environment variables also.
    #
    # @return [Hash<Symbol => void>]
    def defaults
      {
        background:    :default,
        base_path:     base_path,
        colour_mode:   detect_colour_mode,
        compression:   true,
        debug:         false,
        drb:           false,
        drb_host:      nil,
        drb_port:      nil,
        drb_height:    25,
        drb_width:     80,
        foreground:    :default,
        height:        nil,
        interactive:   true,
        log:           nil,
        log_except:    [],
        log_only:      [],
        mouse:         true,
        once:          false,
        profile:       false,
        renderers:     [],
        root:          nil,
        stdin:         nil,
        stdout:        nil,
        stderr:        nil,
        terminal_mode: :raw,
        width:         nil,
      }
    end

    # Attempt to determine the terminal colour mode via $TERM
    # environment variable, or be optimistic and settle for 256
    # colours.
    #
    # @return [Fixnum]
    def detect_colour_mode
      case ENV['TERM']
      when 'xterm-256color', 'screen-256color'
        256
      when 'xterm', 'screen', 'xterm-color', 'screen-color', 'rxvt'
        16
      else
        256
      end
    end

    # @return [String]
    def base_path
      File.expand_path('.')
    end

  end # Configuration

  # @!method config
  #   @see Vedeu::Configuration.config
  # @!method configure
  #   @see Vedeu::Configuration.configure
  # @!method configuration
  #   @see Vedeu::Configuration.configuration
  # @!method height
  #   @see Vedeu::Configuration.height
  # @!method width
  #   @see Vedeu::Configuration.width
  def_delegators Vedeu::Configuration,
                 :config,
                 :configure,
                 :configuration,
                 :height,
                 :width

  # Sets up a default configuration. Client applications calling using
  # the `Vedeu.configure` API method will override these settings.
  Vedeu.configure({})

end # Vedeu
