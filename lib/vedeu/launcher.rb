module Vedeu

  # This class ensures that STDIN, STDOUT and STDERR point to the correct
  # places. It also handles the initial configuration of the application,
  # the starting of the application, the handling of uncaught exceptions and
  # finally the exiting of the application with the correct exit code.
  #
  # @api public
  #
  class Launcher

    # @!attribute [r] exit_code
    # @return [Fixnum] Return value indicating successful execution (0) or an
    #   error occurred (1).
    attr_reader :exit_code

    # @param (see #initialize)
    def self.execute!(argv = [],
                      stdin  = STDIN,
                      stdout = STDOUT,
                      stderr = STDERR,
                      kernel = Kernel)
      new(argv,
          stdin  = STDIN,
          stdout = STDOUT,
          stderr = STDERR,
          kernel = Kernel).debug_execute!
    end

    # Returns a new instance of Vedeu::Launcher.
    #
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

    # @return [void]
    def debug_execute!
      if configuration.debug?
        Vedeu.debug { execute! }

      else
        execute!

      end

      terminate!
    end

    # @return [void]
    def execute!
      $stdin, $stdout, $stderr = @stdin, @stdout, @stderr

      Vedeu::Application.start(configuration)

      @exit_code = 0

    rescue StandardError => uncaught_exception
      puts uncaught_exception.message
      puts uncaught_exception.backtrace.join("\n") if configuration.debug?
    end

    private

    # @!attribute [r] argv
    # @return [Array<String>] The command line arguments provided.
    attr_reader :argv

    # Terminates the application after resetting $stdin, $stdout and $stderr.
    #
    # @return [void]
    def terminate!
      Vedeu.log(type: :info, message: 'Exiting gracefully.')

      $stdin, $stdout, $stderr = STDIN, STDOUT, STDERR

      @kernel.exit(exit_code)
    end

    # @return [Vedeu::Configuration]
    def configuration
      Vedeu::Configuration.configure(argv)

      # Configuration.configure(argv, { stdin:  @stdin,
      #                                 stdout: @stdout,
      #                                 stderr: @stderr })
    end

  end # Launcher

end # Vedeu
