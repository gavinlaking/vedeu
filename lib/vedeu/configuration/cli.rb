module Vedeu

  module Configuration

    # The Configuration::CLI class parses command-line arguments using
    # OptionParser into options used by Vedeu to affect certain behaviours.
    #
    # @api private
    class CLI

      # Configure Vedeu via command-line arguments. Options set here via
      # arguments override the client application configuration set via
      # {Vedeu::API#configure}.
      #
      # @param args [Array]
      # @return [Hash]
      def self.configure(args = [])
        new(args = []).configuration
      end

      # Returns an instance of Configuration::CLI.
      #
      # @param args [Array]
      # @return [Configuration::CLI]
      def initialize(args = [])
        @args = args
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
            Vedeu.log("Configuration::CLI interactive: true")

            options[:interactive] = true
          end

          opts.on('-I', '--noninteractive', '--standalone',
                  'Run the application non-interactively; i.e. not requiring ' \
                  'intervention from the user.') do
            Vedeu.log("Configuration::CLI interactive: false")

            options[:interactive] = false
          end

          opts.on('-1', '--run-once',
                  'Run the application loop once.') do
            Vedeu.log("Configuration::CLI once: true")

            options[:once] = true
          end

          opts.on('-n', '--run-many',
                  'Run the application loop continuously (default).') do
            Vedeu.log("Configuration::CLI once: false")

            options[:once] = false
          end

          opts.on('-c', '--cooked', 'Run application in cooked mode.') do
            Vedeu.log("Configuration::CLI terminal_mode: :cooked")

            options[:terminal_mode] = :cooked
          end

          opts.on('-r', '--raw', 'Run application in raw mode (default).') do
            Vedeu.log("Configuration::CLI terminal_mode: :raw")

            options[:terminal_mode] = :raw
          end

          opts.on('-d', '--debug', 'Run application with debugging on.') do
            Vedeu.log("Configuration::CLI debug: true")

            options[:debug] = true
          end

          opts.on('-D', '--trace', 'Run application with debugging on with ' \
                                   'method and event tracing (noisy!).') do
            Vedeu.log("Configuration::CLI trace: true")

            options[:debug] = true
            options[:trace] = true
          end

          opts.on('-C', '--colour-mode [COLOURS]', Integer,
                  'Run application in either `8`, `16`, `256` or `16777216` ' \
                  'colour mode.') do |colours|
            if [8, 16, 256, 16777216].include?(colours)
              Vedeu.log("Configuration::CLI colour_mode: #{colours.to_s}")

              options[:colour_mode] = colours

            else
              Vedeu.log("Configuration::CLI colour_mode: 8 (defaulted)")

              options[:colour_mode] = 8

            end
          end
        end
        parser.parse!(args)

        options
      end

      private

      attr_reader :args

      # Returns the options set via command-line arguments parsed by
      # OptionParser, or an empty Hash if none were set or parsed.
      #
      # @api private
      # @return [Hash]
      def options
        @_options ||= {}
      end

    end

  end

end
