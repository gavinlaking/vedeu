require 'pty'
require 'vedeu/distributed/test_application'

# app_config = Vedeu::TestApplication.build
# timestamp = Time.now.to_i
# file = File.new("/tmp/foo_#{timestamp}", "w")
# file.write(app_config)
# file.close

# cmd = "ruby #{file.path}"
# begin
#   PTY.spawn(cmd) do |stdin, stdout, pid|
#     begin
#       # Do stuff with the output here. Just printing to show it works
#       stdin.each { |line| print line }
#     rescue Errno::EIO
#       puts "Errno:EIO error, but this probably just means " +
#             "that the process has finished giving output"
#     end
#   end
# rescue PTY::ChildExited
#   puts "The child process exited!"
# ensure
#   File.unlink("/tmp/foo_#{timestamp}")
# end

module Vedeu

  # @example
  #   Vedeu::TestApplication.build
  #
  class Subprocess

    # @param application [Vedeu::TestApplication]
    # @return []
    def self.execute!(application)
      new(application).execute!
    end

    # @param application [Vedeu::TestApplication]
    # @return [Vedeu::Subprocess]
    def initialize(application)
      @application = application
    end

    # @return []
    def execute!
      file_open && file_write && file_close

      begin
        PTY.spawn(command) do |stdin, stdout, pid|
          begin
            stdin.each { |line| print line }

          rescue Errno::EIO
            puts 'Errno::EIO: Process may have stopped giving output.'

          end
        end
      rescue PTY::ChildExited
        puts 'PTY::ChildExited: Process exited.'

      ensure
        file_unlink

      end
    end

    private

    attr_reader :application

    # @return [String]
    def command
      "ruby #{file_path}"
    end

    # @return []
    def file_write
      file.write(application)
    end

    # @return []
    def file_close
      file.close
    end

    # @return []
    def file_unlink
      File.unlink("/tmp/foo_#{timestamp}")
    end

    # return [String]
    def file_path
      file.path
    end

    # @return []
    def file_open
      @file ||= File.new("/tmp/foo_#{timestamp}", "w")
    end
    alias_method :file, :file_open

    # return [Fixnum]
    def timestamp
      @timestamp ||= Time.now.to_i
    end

  end # Subprocess

end # Vedeu
