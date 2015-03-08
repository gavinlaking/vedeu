require 'vedeu/configuration/configuration'

module Vedeu

  # Allows the creation of a lock-less log device.
  #
  class MonoLogger < Logger

    # Create a trappable Logger instance.
    #
    # @param logdev [String|IO] The filename (String) or IO object (typically
    #   STDOUT, STDERR or an open file).
    # @param shift_age [] Number of old log files to keep, or frequency of
    #   rotation (daily, weekly, monthly).
    # @param shift_size [] Maximum log file size (only applies when shift_age
    #   is a number).
    #
    # @example
    #   Logger.new(name, shift_age = 7, shift_size = 1048576)
    #   Logger.new(name, shift_age = 'weekly')
    #
    def initialize(logdev, shift_age=nil, shift_size=nil)
      @level = DEBUG
      @default_formatter = Formatter.new
      @formatter = nil
      @logdev = nil
      if logdev
        @logdev = LocklessLogDevice.new(logdev)
      end
    end

    # Ensures we can always write to the log file by creating a lock-less
    # log device.
    class LocklessLogDevice < LogDevice

      # @param log []
      # @return []
      def initialize(log = nil)
        @dev = nil
        @filename = nil
        @shift_age = nil
        @shift_size = nil

        if log.respond_to?(:write) && log.respond_to?(:close)
          @dev = log

        else
          @dev = open_logfile(log)
          @dev.sync = true
          @filename = log

        end
      end

      # @param message []
      # @return []
      def write(message)
        @dev.write(message)

      rescue Exception => ignored
        warn("log writing failed. #{ignored}")

      end

      # @return []
      def close
        @dev.close rescue nil
      end

      private

      # @param filename []
      # @return []
      def open_logfile(filename)
        if (FileTest.exist?(filename))
          open(filename, (File::WRONLY | File::APPEND))

        else
          logdev = open(filename, (File::WRONLY | File::APPEND | File::CREAT))
          logdev.sync = true
          logdev

        end
      end

    end # LocklessLogDevice

  end # MonoLogger

  # Provides the ability to log anything to the Vedeu log file.
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
        MonoLogger.new(log_file).tap do |log|
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
        Vedeu::Esc.send(message_types.fetch(type, :default)) { "[#{type}]".ljust(9) }
      end

      # @return [Hash]
      def message_types
        {
          config: :yellow,
          create: :green,
          debug:  :red,
          drb:    :blue,
          event:  :magenta,
          info:   :default,
          input:  :yellow,
          output: :green,
          store:  :cyan,
          test:   :white,
          update: :cyan,
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
