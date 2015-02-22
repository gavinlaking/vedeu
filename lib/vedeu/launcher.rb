module Vedeu

  # This class ensures that STDIN, STDOUT and STDERR point to the correct
  # places. It also handles the initial configuration of the application,
  # the starting of the application, the handling of uncaught exceptions and
  # finally the exiting of the application with the correct exit code.
  #
  # @api public
  #
  class Launcher

    attr_reader :exit_code

    # @see Vedeu::Launcher#initialize
    def self.execute!(argv = [],
                      stdin  = STDIN,
                      stdout = STDOUT,
                      stderr = STDERR,
                      kernel = Kernel)
      new(argv,
          stdin  = STDIN,
          stdout = STDOUT,
          stderr = STDERR,
          kernel = Kernel).execute!
    end

    # @param argv [Array]
    # @param stdin [IO]
    # @param stdout [IO]
    # @param stderr [IO]
    # @param kernel [Kernel]
    # @return [Launcher]
    def initialize(argv   = [],
                   stdin  = STDIN,
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

      Application.start(configuration)

      @exit_code = 0

    rescue StandardError => uncaught_exception
      puts uncaught_exception.message
      puts uncaught_exception.backtrace.join("\n") if configuration.debug?

    ensure
      Vedeu.log("Exiting gracefully.")

      $stdin, $stdout, $stderr = STDIN, STDOUT, STDERR
      @kernel.exit(exit_code)
    end

    private

    attr_reader :argv

    # @return [Vedeu::Configuration]
    def configuration
      Vedeu::Configuration.configure(argv)

      # Configuration.configure(argv, { stdin:  @stdin,
      #                                 stdout: @stdout,
      #                                 stderr: @stderr })
    end

  end # Launcher

end # Vedeu
