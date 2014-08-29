module Vedeu
  class Launcher

    # :nocov:
    # @param argv [Array]
    # @param stdin []
    # @param stdout []
    # @param stderr []
    # @param kernel []
    # @return [Launcher]
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

    # @return []
    def execute!
      $stdin, $stdout, $stderr = @stdin, @stdout, @stderr

      Application.start

      @exit_code = 0
    rescue StandardError => uncaught_exception
      puts uncaught_exception.message
      puts uncaught_exception.backtrace.join("\n")

    ensure
      $stdin, $stdout, $stderr = STDIN, STDOUT, STDERR
      @kernel.exit(@exit_code)

    end

    private

    attr_reader :argv

    # @return []
    def configuration
      Configuration.configure(argv)
    end
    # :nocov:

  end
end
