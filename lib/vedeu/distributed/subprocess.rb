# frozen_string_literal: true

module Vedeu

  module Distributed

    # Creates a subprocess of the DRb server.
    #
    class Subprocess

      # @param (see #initialize)
      def self.execute!(application)
        new(application).execute!
      end

      # Returns a new instance of Vedeu::Distributed::Subprocess.
      #
      # @param application [void]
      # @return [Vedeu::Distributed::Subprocess]
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

      protected

      # @!attribute [r] application
      # @return [void]
      attr_reader :application

      # @!attribute [r] pid
      # @return [Fixnum]
      attr_reader :pid

      private

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
        File.unlink(file_name)
      end

      # return [String]
      def file_path
        file.path
      end

      # @return [File]
      def file_open
        @file ||= File.new(file_name, 'w', 0755)
      end
      alias file file_open

      # @return [String]
      def file_name
        "/tmp/foo_#{timestamp}"
      end

      # return [Fixnum]
      def timestamp
        @timestamp ||= Time.now.to_i
      end

    end # Subprocess

  end # Distributed

end # Vedeu
