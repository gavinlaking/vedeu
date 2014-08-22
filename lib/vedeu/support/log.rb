require 'fileutils'
require 'time'

module Vedeu
  class Log
    def self.logger
      @logger ||= Logger.new(filename).tap do |log|
        log.formatter = proc do |_, time, _, message|
          time.utc.iso8601 + ": " + message + "\n"
        end
      end
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
