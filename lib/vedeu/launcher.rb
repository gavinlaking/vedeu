require 'vedeu/application'
require 'vedeu/configuration'

module Vedeu
  class Launcher
    def initialize(argv, stdin  = STDIN,
                         stdout = STDOUT,
                         stderr = STDERR,
                         kernel = Kernel)
      @argv      = argv
      @stdin     = stdin
      @stdout    = stdout
      @stderr    = stderr
      @kernel    = kernel
      @exit_code = 1
    end

    def execute!
      $stdin, $stdout, $stderr = @stdin, @stdout, @stderr

      Application.start(configuration)

      @exit_code = 0
    # rescue Vedeu::API::InvalidHeight, Vedeu::API::InvalidWidth
    #   Vedeu.error("Cannot run this application.\n " \
    #               "Your terminal window is too small.")

    rescue StandardError => uncaught_exception
      puts uncaught_exception.message
      puts uncaught_exception.backtrace.join("\n")

    ensure
      $stdin, $stdout, $stderr = STDIN, STDOUT, STDERR
      @kernel.exit(@exit_code)

    end

    private

    attr_reader :argv

    def configuration
      Configuration.configure(argv)
    end
  end
end
