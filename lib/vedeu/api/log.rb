require 'fileutils'
require 'time'

module Vedeu
  module API
    class Log
      def self.logger
        @logger ||= Logger.new(filename).tap do |log|
          log.formatter = proc do |_, time, _, message|
            time.utc.iso8601 + ": " + message + "\n"
          end
        end
      end

      def self.error(exception)
        backtrace = exception.backtrace.join("\n")
        message   = exception.message + "\n" + backtrace

        logger.debug(message)
      end

      private

      def self.filename
        @_filename ||= directory + '/vedeu.log'
      end

      def self.directory
        FileUtils.mkdir_p(path) unless File.directory?(path)

        path
      end

      def self.path
        Dir.home + '/.vedeu'
      end
    end
  end
end
