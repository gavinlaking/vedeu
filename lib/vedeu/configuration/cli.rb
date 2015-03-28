require 'optparse'

module Vedeu

  module Config

    # The Configuration::CLI class parses command-line arguments using
    # OptionParser into options used by Vedeu to affect certain behaviours.
    #
    class CLI

      # @param (see #initialize)
      def self.configure(args = [])
        new(args).configuration
      end

      # Configure Vedeu via command-line arguments. Options set here via
      # arguments override the client application configuration set via
      # {Vedeu::API#configure}.
      #
      # @param args [Array]
      # @return [Configuration::CLI]
      def initialize(args = [])
        @args    = args
        @options = {}
      end

      # Returns the configuration options set up by parsing the command-line
      # arguments passed to the client application.
      #
      # @return [Hash]
      def configuration
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
            if [8, 16, 256, 16_777_216].include?(colours)
              options[:colour_mode] = colours

            else
              options[:colour_mode] = 8

            end
          end

          opts.on('-l', '--log [FILENAME]', String,
                  'Specify the path for the log file.') do |filename|
            options[:log] = filename
          end

          opts.on('--drb', 'Run application with DRb on.') do
            options[:drb] = true
          end

          opts.on('--drb-host',
            'Set the hostname/IP for the DRb server.') do |hostname|
            #options[:drb]      = true
            options[:drb_host] = hostname
          end

          opts.on('--drb-port', 'Set the port for the DRb server.') do |port|
            # options[:drb]    = true
            options[:drb_port] = port
          end

          opts.on('--drb-height', 'Set the height for fake terminal of the DRb server.') do |height|
            # options[:drb]      = true
            options[:drb_height] = height
          end

          opts.on('--drb-width', 'Set the width for fake terminal of the DRb server.') do |width|
            # options[:drb]     = true
            options[:drb_width] = width
          end
        end

        parser.parse!(args)

        Vedeu::Config.log('CLI', options)
      end

      private

      # @!attribute [r] args
      # @return [Array<String>]
      attr_reader :args

      # @!attribute [r] options
      # @return [Hash]
      attr_reader :options

    end # CLI

  end # Config

end # Vedeu
