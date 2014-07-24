require 'vedeu/application'
require 'vedeu/configuration'

module Vedeu
  class Launcher
    # :nocov:
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

      $stderr.reopen("logs/vedeu.log", "w")

      Application.start(configuration)

      @exit_code = 0
    rescue StandardError => uncaught_exception
      Vedeu.error(uncaught_exception)
    ensure
      $stdin, $stdout, $stderr = STDIN, STDOUT, STDERR
      @kernel.exit(@exit_code)
    end

    private

    attr_reader :argv

    def configuration
      Configuration.configure(argv)
    end
    # :nocov:
  end
end
