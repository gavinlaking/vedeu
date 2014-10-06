module Vedeu

  # This class ensures that STDIN, STDOUT and STDERR point to the correct
  # places. It also handles the initial configuration of the application,
  # the starting of the application, the handling of uncaught exceptions and
  # finally the exiting of the application with the correct exit code.
  #
  # @api public
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

      Configuration.configure(argv)

      Application.start

      @exit_code = 0
    rescue StandardError => uncaught_exception
      puts uncaught_exception.message
      puts uncaught_exception.backtrace.join("\n")

    ensure
      Vedeu.log("Exiting gracefully.")

      $stdin, $stdout, $stderr = STDIN, STDOUT, STDERR
      @kernel.exit(@exit_code)

    end

    private

    attr_reader :argv

  end # Launcher

end # Vedeu
