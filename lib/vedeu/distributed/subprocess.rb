require 'vedeu/distributed/test_application'

module Vedeu

  # @example
  #   Vedeu::TestApplication.build
  #
  class Subprocess

    # @param (see #initialize)
    def self.execute!(application)
      new(application).execute!
    end

    # Returns a new instance of Vedeu::Subprocess.
    #
    # @param application [Vedeu::TestApplication]
    # @return [Vedeu::Subprocess]
    def initialize(application)
      @application = application
      @pid         = nil
    end

    # :nocov:
    # @return [Array]
    def execute!
      file_open && file_write && file_close

      @pid = fork do
        exec(file_path)
      end

      Process.detach(@pid)

      self
    end
    # :nocov:

    # Sends the KILL signal to the process.
    #
    # @return [void]
    def kill
      Process.kill('KILL', pid)

      file_unlink
    end

    private

    # @!attribute [r] application
    # @return [Vedeu::TestApplication]
    attr_reader :application

    # @!attribute [rw] pid
    # @return [Fixnum]
    attr_accessor :pid

    # @return [String]
    def command
      "ruby #{file_path}"
    end

    # @return [Fixnum] The number of bytes written.
    def file_write
      file.write(application)
    end

    # @return [NilClass]
    def file_close
      file.close
    end

    # @return [Fixnum] The number of files removed; 1.
    def file_unlink
      File.unlink("/tmp/foo_#{timestamp}")
    end

    # return [String]
    def file_path
      file.path
    end

    # @return [File]
    def file_open
      @file ||= File.new("/tmp/foo_#{timestamp}", 'w', 0755)
    end
    alias_method :file, :file_open

    # return [Fixnum]
    def timestamp
      @timestamp ||= Time.now.to_i
    end

  end # Subprocess

end # Vedeu
