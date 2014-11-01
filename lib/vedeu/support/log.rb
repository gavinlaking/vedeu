require 'fileutils'
require 'time'

module Vedeu

  # Allows the creation of a lock-less log device.
  #
  # @api private
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
      @progname = nil
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

      # @return []
      def initialize(log = nil)
        @dev = @filename = @shift_age = @shift_size = nil
        if log.respond_to?(:write) and log.respond_to?(:close)
          @dev = log
        else
          @dev = open_logfile(log)
          @dev.sync = true
          @filename = log
        end
      end

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

      # @return []
      def open_logfile(filename)
        if (FileTest.exist?(filename))
          open(filename, (File::WRONLY | File::APPEND))
        else
          create_logfile(filename)
        end
      end

      # @return []
      def create_logfile(filename)
        logdev = open(filename, (File::WRONLY | File::APPEND | File::CREAT))
        logdev.sync = true
        add_log_header(logdev)
        logdev
      end

      # @return []
      def add_log_header(file)
        file.write(
          "# Logfile created on %s by %s\n" % [Time.now.to_s, Logger::ProgName]
        )
      end
    end

  end

  # Provides the ability to Log anything to the Vedeu log file which is
  # hard-coded to reside in `$HOME/.vedeu/vedeu.log`.
  #
  # @api private
  class Log

    # @return [TrueClass]
    def self.logger
      @logger ||= MonoLogger.new(filename).tap do |log|
        log.formatter = proc do |_, time, _, message|
          utc_time = time.utc.iso8601

          [timestamp(utc_time), message, "\n"].join
        end
      end
    end

    private

    def self.timestamp(utc_time)
      return "" if @last_seen == utc_time

      @last_seen = utc_time

      "\n\e[4m\e[31m" + utc_time + "\e[39m\e[24m\n"
    end

    # @return [String]
    def self.filename
      @_filename ||= directory + '/vedeu.log'
    end

    # @return [String]
    def self.directory
      FileUtils.mkdir_p(path) unless File.directory?(path)

      path
    end

    # @return [String]
    def self.path
      Dir.home + '/.vedeu'
    end

  end # Log

end # Vedeu
