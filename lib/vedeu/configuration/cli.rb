require 'optparse'

module Vedeu

  module Config

    # The Configuration::CLI class parses command-line arguments using
    # OptionParser into options used by Vedeu to affect certain behaviours.
    #
    # @api private
    #
    class CLI

      # Configure Vedeu via command-line arguments. Options set here via
      # arguments override the client application configuration set via
      # {Vedeu::API#configure}.
      #
      # @param args [Array]
      # @return [Hash]
      def self.configure(args = [])
        new(args).configuration
      end

      # Returns an instance of Configuration::CLI.
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
            Vedeu.log(type: :info, message: "Configuration::CLI interactive: true")

            options[:interactive] = true
          end

          opts.on('-I', '--noninteractive', '--standalone',
                  'Run the application non-interactively; i.e. not requiring ' \
                  'intervention from the user.') do
            Vedeu.log(type: :info, message: "Configuration::CLI interactive: false")

            options[:interactive] = false
          end

          opts.on('-1', '--run-once',
                  'Run the application loop once.') do
            Vedeu.log(type: :info, message: "Configuration::CLI once: true")

            options[:once] = true
          end

          opts.on('-n', '--run-many',
                  'Run the application loop continuously (default).') do
            Vedeu.log(type: :info, message: "Configuration::CLI once: false")

            options[:once] = false
          end

          opts.on('-c', '--cooked', 'Run application in cooked mode.') do
            Vedeu.log(type: :info, message: "Configuration::CLI terminal_mode: :cooked")

            options[:terminal_mode] = :cooked
          end

          opts.on('-r', '--raw', 'Run application in raw mode (default).') do
            Vedeu.log(type: :info, message: "Configuration::CLI terminal_mode: :raw")

            options[:terminal_mode] = :raw
          end

          opts.on('-d', '--debug', 'Run application with debugging on.') do
            Vedeu.log(type: :info, message: "Configuration::CLI debug: true")

            options[:debug] = true
          end

          opts.on('-D', '--trace', 'Run application with debugging on with ' \
                                   'method and event tracing (noisy!).') do
            Vedeu.log(type: :info, message: "Configuration::CLI trace: true")

            options[:debug] = true
            options[:trace] = true
          end

          opts.on('-C', '--colour-mode [COLOURS]', Integer,
                  'Run application in either `8`, `16`, `256` or `16777216` ' \
                  'colour mode.') do |colours|
            if [8, 16, 256, 16777216].include?(colours)
              Vedeu.log(type: :info, message: "Configuration::CLI colour_mode: #{colours}")

              options[:colour_mode] = colours

            else
              Vedeu.log(type: :info, message: "Configuration::CLI colour_mode: 8 (defaulted)")

              options[:colour_mode] = 8

            end
          end

          opts.on('-l', '--log [FILENAME]', String,
                  'Specify the path for the log file.') do |filename|
            Vedeu.log(type: :info, message: "Configuration::CLI log: #{filename}")

            options[:log] = filename
          end

          opts.on('--drb', 'Run application with DRb on.') do
            Vedeu.log(type: :info, message: "Configuration::CLI drb: true")

            options[:drb] = true
          end

          opts.on('--drb-host', 'Set the hostname/IP for the DRb server.') do |hostname|
            Vedeu.log(type: :info, message: "Configuration::CLI drb_host: #{hostname}")

            #options[:drb]      = true
            options[:drb_host] = hostname
          end

          opts.on('--drb-port', 'Set the port for the DRb server.') do |port|
            Vedeu.log(type: :info, message: "Configuration::CLI drb_port: #{port}")

            #options[:drb]      = true
            options[:drb_port] = port
          end

          opts.on('--drb-height', 'Set the height for fake terminal of the DRb server.') do |height|
            Vedeu.log(type: :info, message: "Configuration::CLI drb_height: #{height}")

            #options[:drb]      = true
            options[:drb_height] = height
          end

          opts.on('--drb-width', 'Set the width for fake terminal of the DRb server.') do |width|
            Vedeu.log(type: :info, message: "Configuration::CLI drb_width: #{width}")

            #options[:drb]      = true
            options[:drb_width] = width
          end
        end

        parser.parse!(args)

        options
      end

      private

      attr_reader :args, :options

    end # CLI

  end # Config

end # Vedeu
