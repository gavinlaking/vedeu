module Vedeu

  # Allows the customisation of Vedeu's behaviour through the configuration API
  # or command-line arguments.

  # Provides access to Vedeu's configuration, which was set with sensible
  # defaults (influenced by environment variables), overridden by client
  # application settings (via the configuration API), or any command-line
  # arguments provided.
  #
  # @api private
  module Configuration

    extend self

    # Configure Vedeu with sensible defaults. If the client application sets
    # options, override the defaults with those, and if command-line arguments
    # are provided at application invocation, override any options with the
    # arguments provided.
    #
    # @param args [Array]
    # @param block [Proc]
    # @return [Hash]
    def configure(args = [], &block)
      options.merge!(API.configure(&block)) if block_given?

      options.merge!(CLI.configure(args)) if args.any?

      options
    end

    # Returns the chosen colour mode.
    #
    # @return [Fixnum]
    def colour_mode
      options[:colour_mode]
    end

    # Returns whether debugging is enabled or disabled. Default is false;
    # meaning nothing apart from warnings are written to the log file.
    #
    # @return [Boolean]
    def debug?
      options[:debug]
    end
    alias_method :debug, :debug?

    # Returns whether the application is interactive (required user input) or
    # standalone (will run until terminates of natural causes.) Default is true;
    # meaning the application will require user input.
    #
    # @return [Boolean]
    def interactive?
      options[:interactive]
    end
    alias_method :interactive, :interactive?

    # Returns whether the application will run through its main loop once or
    # not. Default is false; meaning the application will loop forever or until
    # terminated by the user.
    #
    # @return [Boolean]
    def once?
      options[:once]
    end
    alias_method :once, :once?

    # Returns
    #
    # @return [Hash]
    def system_keys
      options[:system_keys]
    end

    # Returns the terminal mode for the application. Default is `:raw`.
    #
    # @return [Symbol]
    def terminal_mode
      options[:terminal_mode]
    end

    # Returns whether tracing is enabled or disabled. Tracing is very noisy in
    # the log file (logging method calls and events trigger). Default is false;
    # meaning tracing is disabled.
    #
    # @return [Boolean]
    def trace?
      options[:trace]
    end
    alias_method :trace, :trace?

    # Resets all options to Vedeu defaults.
    #
    # @return [Hash]
    def reset
      @options = defaults
    end

    # Vedeu's default system keys. Use {#system_keys}.
    #
    # @api private
    # @return [Hash]
    def default_system_keys
      {
        exit:        'q',
        focus_next:  :tab,
        focus_prev:  :shift_tab,
        mode_switch: :escape,
      }
    end

    private

    # Returns all the options current configured.
    #
    # @api private
    # @return [Hash]
    def options
      @options ||= defaults
    end

    # The Vedeu default options, which of course are influenced by environment
    # variables also.
    #
    # @api private
    # @return [Hash]
    def defaults
      {
        colour_mode:   detect_colour_mode,
        debug:         detect_debug_mode,
        interactive:   true,
        once:          false,
        system_keys:   default_system_keys,
        terminal_mode: :raw,
        trace:         detect_trace_mode,
      }
    end

    # Attempt to determine the terminal colour mode via environment variables,
    # or be optimistic and settle for 256 colours.
    #
    # @api private
    # @return [Fixnum]
    # :nocov:
    def detect_colour_mode
      return 16777216 if ENV['VEDEU_TESTMODE']

      if ENV['VEDEU_TERM']
        case ENV['VEDEU_TERM']
        when /-256color$/  then 256
        when /-truecolor$/ then 16777216
        else 256
        end

      elsif ENV['TERM']
        case ENV['TERM']
        when /-256color$/, 'xterm' then 256
        when /-color$/, 'rxvt'     then 16
        else 256
        end

      else
        256

      end
    end
    # :nocov:

    # Determine the debug mode via an environment variable.
    #
    # @api private
    # @return [Boolean]
    # :nocov:
    def detect_debug_mode
      return false if ENV['VEDEU_TESTMODE']

      return true if ENV['VEDEU_DEBUG']

      false
    end
    # :nocov:

    # Determine the trace mode via an environment variable.
    #
    # @api private
    # @return [Boolean]
    # :nocov:
    def detect_trace_mode
      return false if ENV['VEDEU_TESTMODE']

      return true if ENV['VEDEU_TRACE']

      false
    end
    # :nocov:

  end # Configuration

end # Vedeu
