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
                'Run application in particular colour mode. `3`, `8` and `24`' \
                ' bit modes supported.') do |mode|
          if ['3', '8', '24'].include?(mode)
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

    def defaults
      {
        colour_mode: detect_colour_mode,
        debug:       false,
        interactive: true,
        mode:        :raw
      }
    end

    def detect_colour_mode
      24
    end

  end
end
