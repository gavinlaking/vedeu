module Vedeu
  module Configuration
    extend self

    # @param args [Array]
    # @return [Hash]
    def configure(args = [])
      parser = OptionParser.new do |opts|
        opts.banner = "Usage: #{$PROGRAM_NAME} [options]"

        opts.on('-i', '--interactive',
                'Run the application in interactive mode (default).') do
          options[:interactive] = true
        end

        opts.on('-I', '--noninteractive',
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

        opts.on('-C', '--colour-mode',
                'Run application in either `8`, `16` or `256` colour ' \
                'mode.') do |colours|
          if ['8', '16', '256'].include?(colours)
            options[:colour_mode] = colours

          else
            options[:colour_mode] = 8

          end
        end
      end
      parser.parse!(args)

      options
    end

    # @return [Fixnum]
    def colour_mode
      options[:colour_mode]
    end

    # @return [TrueClass|FalseClass]
    def debug?
      options[:debug]
    end
    alias_method :debug, :debug?

    # @return [TrueClass|FalseClass]
    def interactive?
      options[:interactive]
    end
    alias_method :interactive, :interactive?

    # @return [TrueClass|FalseClass]
    def once?
      options[:once]
    end
    alias_method :once, :once?

    # @return [Symbol]
    def terminal_mode
      options[:terminal_mode]
    end

    # @return [TrueClass|FalseClass]
    def trace?
      options[:trace]
    end
    alias_method :trace, :trace?

    # @return [Hash]
    def options
      @options ||= defaults
    end

    # @return [Hash]
    def reset
      @options = defaults
    end

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

    # @return [Fixnum]
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

    # @return [TrueClass|FalseClass]
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

    # @return [TrueClass|FalseClass]
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

  end
end
