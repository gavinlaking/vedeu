module Vedeu

  module Config

    # The Configuration::CLI class parses command-line arguments using
    # OptionParser into options used by Vedeu to affect certain behaviours.
    #
    # @api public
    class CLI

      # @param (see #initialize)
      def self.configure(args = [])
        new(args).configuration
      end

      # Returns a new instance of Vedeu::Config::CLI.
      #
      # Configure Vedeu via command-line arguments. Options set here via
      # arguments override the client application configuration set via
      # {Vedeu::API#configure}.
      #
      # @param args [Array]
      # @return [Vedeu::Configuration::CLI]
      def initialize(args = [])
        @args    = args
        @options = {}
      end

      # Returns the configuration options set up by parsing the command-line
      # arguments passed to the client application.
      #
      # @return [Hash]
      def configuration
        setup!

        parser.parse!(args)

        Vedeu::Config.log(Esc.blue { '[cli]' }, options)
      end

      protected

      # @!attribute [r] args
      # @return [Array<String>]
      attr_reader :args

      # @!attribute [r] options
      # @return [Hash]
      attr_reader :options

      private

      # Setup Vedeu using CLI configuration options for the client application.
      #
      # @return [void]
      def setup!
        ([:banner] + allowed_options).each { |opt| send(opt) }
      end

      # @return [OptionParser]
      def parser
        @parser ||= OptionParser.new
      end

      # @return [Array<Symbol>]
      def allowed_options
        [
          :colour_mode,
          :cooked,
          :debug,
          :drb,
          :drb_height,
          :drb_host,
          :drb_port,
          :drb_width,
          :interactive,
          :log,
          :raw,
          :run_many,
          :run_once,
          :standalone,
        ]
      end

      # @return [String]
      def banner
        parser.banner = "Usage: #{$PROGRAM_NAME} [options]"
      end

      # @return [OptionParser]
      def colour_mode
        parser.on('-C', '--colour-mode [COLOURS]', Integer,
                  'Run application in either `8`, `16`, `256` or `16777216` ' \
                  'colour mode.') do |colours|
          if [8, 16, 256, 16_777_216].include?(colours)
            options[:colour_mode] = colours

          else
            options[:colour_mode] = 8

          end
        end
      end

      # @return [OptionParser]
      def cooked
        parser.on('-c', '--cooked', 'Run application in cooked mode.') do
          options[:terminal_mode] = :cooked
        end
      end

      # @return [OptionParser]
      def debug
        parser.on('-d', '--debug', 'Run application with debugging on.') do
          options[:debug] = true
        end
      end

      # @return [OptionParser]
      def drb
        parser.on('--drb', 'Run application with DRb on.') do
          options[:drb] = true
        end
      end

      # @return [OptionParser]
      def drb_height
        parser.on('--drb-height',
                  'Set the height for fake terminal.') do |height|
          options[:drb]        = true
          options[:drb_height] = height
        end
      end

      # @return [OptionParser]
      def drb_host
        parser.on('--drb-host',
                  'Set the hostname/IP for the DRb server.') do |hostname|
          options[:drb]      = true
          options[:drb_host] = hostname
        end
      end

      # @return [OptionParser]
      def drb_port
        parser.on('--drb-port', 'Set the port for the DRb server.') do |port|
          options[:drb]      = true
          options[:drb_port] = port
        end
      end

      # @return [OptionParser]
      def drb_width
        parser.on('--drb-width',
                  'Set the width for fake terminal.') do |width|
          options[:drb]       = true
          options[:drb_width] = width
        end
      end

      # @return [OptionParser]
      def interactive
        parser.on('-i', '--interactive',
                  'Run the application in interactive mode (default).') do
          options[:interactive] = true
        end
      end

      # @return [OptionParser]
      def log
        parser.on('-l', '--log [FILENAME]', String,
                  'Specify the path for the log file.') do |filename|
          options[:log] = filename
        end
      end

      # @return [OptionParser]
      def raw
        parser.on('-r', '--raw', 'Run application in raw mode (default).') do
          options[:terminal_mode] = :raw
        end
      end

      # @return [OptionParser]
      def run_many
        parser.on('-n', '--run-many',
                  'Run the application loop continuously (default).') do
          options[:once] = false
        end
      end

      # @return [OptionParser]
      def run_once
        parser.on('-1', '--run-once', 'Run the application loop once.') do
          options[:once] = true
        end
      end

      # @return [OptionParser]
      def standalone
        parser.on('-I', '--noninteractive', '--standalone',
                  'Run the application non-interactively; ' \
                  'i.e. not requiring intervention from the user.') do
          options[:interactive] = false
        end
      end

    end # CLI

  end # Config

end # Vedeu
