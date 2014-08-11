module Vedeu
  class Configuration
    def self.configure(args = [])
      new(args).configure
    end

    def initialize(args = [])
      @args    = args
      @options = {}
    end

    def configure
      parser = OptionParser.new do |opts|
        opts.banner = "Usage: #{$PROGRAM_NAME} [options]"

        opts.on('-1', '--run-once', 'Run application once.') do
          options[:interactive] = false
        end

        opts.on('-c', '--cooked', 'Run application in cooked mode.') do
          options[:mode] = :cooked
        end

        opts.on('-r', '--raw', 'Run application in raw mode (default).') do
          options[:mode] = :raw
        end

        opts.on('-d', '--debug', 'Run application with debugging on.') do
          options[:debug] = true
        end
      end
      parser.parse!(args)

      options
    end

    private

    attr_accessor :args, :options
  end
end
