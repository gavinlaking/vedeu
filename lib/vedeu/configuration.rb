module Vedeu
  class Configuration

    # @param args [Array]
    # @return [Hash]
    def self.configure(args = [])
      new(args).configure
    end

    # @return [Hash]
    def self.options
      new.options
    end

    # @param args [Array]
    # @return [Configuration]
    def initialize(args = [])
      @_options = {}
      @args     = args
    end

    # @return [Hash]
    def configure
      parser = OptionParser.new do |opts|
        opts.banner = "Usage: #{$PROGRAM_NAME} [options]"

        opts.on('-1', '--run-once', 'Run application once.') do
          _options[:interactive] = false
        end

        opts.on('-c', '--cooked', 'Run application in cooked mode.') do
          _options[:mode] = :cooked
        end

        opts.on('-r', '--raw', 'Run application in raw mode (default).') do
          _options[:mode] = :raw
        end

        opts.on('-d', '--debug', 'Run application with debugging on.') do
          _options[:debug] = true
        end

        opts.on('-C',
                '--colour-mode',
                'Run application in either `16` or `256` colour mode.') do |mode|
          if ['16', '256'].include?(mode)
            _options[:colour_mode] = mode

          else
            exit

          end
        end
      end
      parser.parse!(args)

      _options
    end

    # @return [Hash]
    def options
      @options ||= defaults.merge!(@_options)
    end

    private

    attr_accessor :args, :_options

    # @return [Hash]
    def defaults
      {
        colour_mode: detect_colour_mode,
        debug:       false,
        interactive: true,
        mode:        :raw
      }
    end

    # @return [Fixnum]
    def detect_colour_mode
      if ENV['VEDEUTERM']
        case ENV['VEDEUTERM']
        when /-256color$/  then 256
        when /-truecolor$/ then 16777216
        else
          256
        end

      else
        case ENV['TERM']
        when /-256color$/, 'xterm' then 256
        when /-color$/, 'rxvt'     then 16
        else
          256
        end

      end
    end

  end
end
