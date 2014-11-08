module Vedeu

  # Provides the ability to log anything to the Vedeu log file.
  #
  # @api private
  class Log

    class << self

      # @return [TrueClass]
      def logger
        Logger.new(Configuration.log).tap do |log|
          log.formatter = proc do |_, time, _, message|
            [timestamp(time.utc.iso8601), message, "\n"].join
          end
        end
      end

      private

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
