require_relative 'application'
require_relative 'configuration'

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

    # :nocov:
    def execute!
      $stdin, $stdout, $stderr = @stdin, @stdout, @stderr

      Application.start(configuration)

      @exit_code = 0
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
