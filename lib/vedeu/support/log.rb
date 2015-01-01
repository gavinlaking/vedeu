require 'vedeu/configuration/configuration'

module Vedeu

  # Provides the ability to log anything to the Vedeu log file.
  #
  # @api private
  class Log

    class << self

      # Write a message to the Vedeu log file.
      #
      # @param message [String] The message you wish to emit to the log
      #   file, useful for debugging.
      # @param force   [Boolean] When evaluates to true will attempt to
      #   write to the log file regardless of the Configuration setting.
      #
      # @example
      #   Vedeu.log('A useful debugging message: Error!')
      #
      # @return [TrueClass]
      def log(message, force = false)
        logger.debug(message) if enabled? || force
      end

      # @return [TrueClass]
      def logger
        Logger.new(log_file).tap do |log|
          log.formatter = proc do |_, time, _, message|
            [timestamp(time.utc.iso8601), message, "\n"].join
          end
        end
      end

      private

      # @return [Boolean]
      def enabled?
        Vedeu::Configuration.debug?
      end

      # @return [String]
      def log_file
        Vedeu::Configuration.log
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
