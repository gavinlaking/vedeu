require 'optparse'

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
          @options[:interactive] = false
        end
      end
      parser.parse!(args)

      options
    end

    private

    attr_accessor :args, :options
  end
end
