module Vedeu

  # TODO: what does this class do?
  module Configuration

    extend self

    # Parses arguments passed on the command-line or via {Vedeu::Launcher} into
    # options used by Vedeu to affect certain behaviours.
    #
    # @param args [Array]
    # @return [Hash]
    def configure(args = [])
      parser = OptionParser.new do |opts|
        opts.banner = "Usage: #{$PROGRAM_NAME} [options]"

        opts.on('-i', '--interactive',
                'Run the application in interactive mode (default).') do
          options[:interactive] = true
        end

        opts.on('-I', '--noninteractive', '--standalone',
                'Run the application non-interactively; i.e. not requiring ' \
                'intervention from the user.') do
          options[:interactive] = false
        end

        opts.on('-1', '--run-once',
                'Run the application loop once.') do
          options[:once] = true
        end

        opts.on('-n', '--run-many',
                'Run the application loop continuously (default).') do
          options[:once] = false
        end

        opts.on('-c', '--cooked', 'Run application in cooked mode.') do
          options[:terminal_mode] = :cooked
        end

        opts.on('-r', '--raw', 'Run application in raw mode (default).') do
          options[:terminal_mode] = :raw
        end

        opts.on('-d', '--debug', 'Run application with debugging on.') do
          options[:debug] = true
        end

        opts.on('-D', '--trace', 'Run application with debugging on with ' \
                                 'method and event tracing (noisy!).') do
          options[:debug] = true
          options[:trace] = true
        end

        opts.on('-C', '--colour-mode [COLOURS]', Integer,
                'Run application in either `8`, `16`, `256` or `16777216` ' \
                'colour mode.') do |colours|
          if [8, 16, 256, 16777216].include?(colours)
            options[:colour_mode] = colours

          else
            options[:colour_mode] = 8

          end
        end
      end
      parser.parse!(args)

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
    # @return [TrueClass|FalseClass]
    def debug?
      options[:debug]
    end
    alias_method :debug, :debug?

    # Returns whether the application is interactive (required user input) or
    # standalone (will run until terminates of natural causes.) Default is true;
    # meaning the application will require user input.
    #
    # @return [TrueClass|FalseClass]
    def interactive?
      options[:interactive]
    end
    alias_method :interactive, :interactive?

    # Returns whether the application will run through its main loop once or
    # not. Default is false; meaning the application will loop forever or until
    # terminated by the user.
    #
    # @return [TrueClass|FalseClass]
    def once?
      options[:once]
    end
    alias_method :once, :once?

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
    # @return [TrueClass|FalseClass]
    def trace?
      options[:trace]
    end
    alias_method :trace, :trace?

    # Returns all the options current configured.
    #
    # @return [Hash]
    def options
      @options ||= defaults
    end

    # Resets all options to Vedeu defaults.
    #
    # @return [Hash]
    def reset
      @options = defaults
    end

    private

    # The Vedeu default options, which of course are influenced by enviroment
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
        terminal_mode: :raw,  #cooked
        trace:         detect_trace_mode,
      }
    end

    # Determine the terminal colour mode via enviroment variables, or be
    # optimistic and settle for 256 colours.
    #
    # @api private
    # @return [Fixnum]
    # :nocov:
    def detect_colour_mode
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

    # Determine the debug mode via an enviroment variable.
    #
    # @api private
    # @return [TrueClass|FalseClass]
    # :nocov:
    def detect_debug_mode
      if ENV['VEDEU_DEBUG']
        case ENV['VEDEU_DEBUG']
        when 'true'  then true
        when 'false' then false
        else false
        end

      else
        false

      end
    end
    # :nocov:

    # Determine the trace mode via an environment variable.
    #
    # @api private
    # @return [TrueClass|FalseClass]
    # :nocov:
    def detect_trace_mode
      if ENV['VEDEU_TRACE']
        case ENV['VEDEU_TRACE']
        when 'true'  then true
        when 'false' then false
        else false
        end

      else
        false

      end
    end
    # :nocov:

  end
end
