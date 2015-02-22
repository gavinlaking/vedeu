require 'vedeu/configuration/configuration'

module Vedeu

  # Provides the ability to log anything to the Vedeu log file.
  #
  # @api private
  #
  class Log

    class << self

      # Write a message to the Vedeu log file.
      #
      # @param message [String] The message you wish to emit to the log file,
      #   useful for debugging.
      # @param force   [Boolean] When evaluates to true will attempt to write to
      #   the log file regardless of the Configuration setting.
      # @param type    [Symbol] Colour code messages in the log file depending
      #   on their source.
      #
      # @example
      #   Vedeu.log(message: 'A useful debugging message: Error!')
      #
      # @return [TrueClass]
      def log(message:, force: false, type: :info)
        logger.debug([message_type(type), message]) if enabled? || force
      end

      # @return [TrueClass]
      def logger
        Logger.new(log_file).tap do |log|
          log.formatter = proc do |_, time, _, message|
            formatted_message(message, time)
          end
        end
      end

      private

      # @return [String]
      def formatted_message(message, time = Time.now)
        [timestamp(time.utc.iso8601), message, "\n"].join
      end

      # @return [Boolean]
      def enabled?
        Vedeu::Configuration.debug?
      end

      # @return [String]
      def log_file
        Vedeu::Configuration.log
      end

      # @return [String]
      def message_type(type)
        Esc.send(message_types.fetch(type, :default)) { "[#{type}]".ljust(9) }
      end

      # @return [Hash]
      def message_types
        {
          debug:  :red,
          drb:    :blue,
          event:  :magenta,
          info:   :default,
          input:  :yellow,
          output: :green,
          store:  :cyan,
          test:   :white,
        }
      end

      # Returns a formatted (red, underlined) UTC timestamp,
      # eg. 2014-10-24T12:34:56Z
      #
      # @return [String]
      def timestamp(utc_time)
        return '' if @last_seen == utc_time

        @last_seen = utc_time

        "\n\e[4m\e[31m" + utc_time + "\e[39m\e[24m\n"
      end

    end # Log eigenclass

  end # Log

end # Vedeu
