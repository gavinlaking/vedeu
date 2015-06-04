module Vedeu

  # Allows the creation of a lock-less log device.
  class MonoLogger < Logger

    # Create a trappable Logger instance.
    #
    # @param logdev [String|IO] The filename (String) or IO object (typically
    #   STDOUT, STDERR or an open file).
    #
    def initialize(logdev)
      @level = DEBUG
      @default_formatter = Formatter.new
      @formatter = nil
      @logdev = nil
      @logdev = LocklessLogDevice.new(logdev) if logdev
    end

    # Ensures we can always write to the log file by creating a lock-less
    # log device.
    #
    class LocklessLogDevice < LogDevice

      # Returns a new instance of Vedeu::LocklessLogDevice.
      #
      # @param log []
      # @return []
      def initialize(log = nil)
        @dev = nil
        @filename = nil

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

      rescue StandardError => exception
        warn("log writing failed. #{exception}")
      end

      # @return []
      def close
        @dev.close rescue nil
      end

      private

      # @param filename []
      # @return []
      def open_logfile(filename)
        if FileTest.exist?(filename)
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
      # @example
      #   Vedeu.log(message: 'A useful debugging message: Error!')
      #
      # @param message [String] The message you wish to emit to the log file,
      #   useful for debugging.
      # @param force [Boolean] When evaluates to true will attempt to write to
      #   the log file regardless of the Configuration setting.
      # @param type [Symbol] Colour code messages in the log file depending
      #   on their source.
      #
      # @return [TrueClass]
      def log(message:, force: false, type: :info)
        logger.debug([message_type(type), message_body(type, message)]) if enabled? || force
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
      def message_body(type, body)
        Vedeu::Esc.send(message_types.fetch(type, :default).last) do
          body
        end
      end


      # @return [String]
      def message_type(type)
        Vedeu::Esc.send(message_types.fetch(type, :default).first) do
          "[#{type}]".ljust(9)
        end
      end

      # @return [Hash<Symbol => Symbol>]
      def message_types
        {
          config: [:light_yellow,  :yellow],
          create: [:light_green,   :green],
          debug:  [:light_red,     :red],
          drb:    [:light_blue,    :blue],
          event:  [:light_magenta, :magenta],
          info:   [:white,         :default],
          input:  [:light_yellow,  :yellow],
          output: [:light_green,   :green],
          store:  [:light_cyan,    :cyan],
          test:   [:light_white,   :white],
          update: [:light_cyan,    :cyan],
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
