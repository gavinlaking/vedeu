module Vedeu

  # This class ensures that STDIN, STDOUT and STDERR point to the correct
  # places. It also handles the initial configuration of the application,
  # the starting of the application, the handling of uncaught exceptions and
  # finally the exiting of the application with the correct exit code.
  #
  class Launcher

    # @!attribute [r] exit_code
    # @return [Fixnum] Return value indicating successful execution (0) or an
    #   error occurred (1).
    attr_reader :exit_code

    # :nocov:
    # @param (see #initialize)
    def self.execute!(argv = [],
                      stdin  = STDIN,
                      stdout = STDOUT,
                      stderr = STDERR,
                      kernel = Kernel)
      new(argv, stdin, stdout, stderr, kernel).debug_execute!
    end
    # :nocov:

    # Returns a new instance of Vedeu::Launcher.
    #
    # @param argv [Array]
    # @param stdin [IO]
    # @param stdout [IO]
    # @param stderr [IO]
    # @param kernel [Kernel]
    # @return [Vedeu::Launcher]
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

    # :nocov:
    # If debugging is enabled, execute the application within the debugging
    # context. At the moment, this simple uses 'ruby-prof' to profile the
    # running application.
    #
    # @return [void]
    def debug_execute!
      if configuration.debug?
        Vedeu.debug { execute! }

      else
        execute!

      end

      terminate!
    end
    # :nocov:

    # Alters the STD[IN|OUT|ERR] to those requested by the client application,
    # then starts the application. If an uncaught exception occurs during the
    # application runtime, we exit ungracefully with any error message(s).
    #
    # @return [void]
    def execute!
      $stdin  = @stdin
      $stdout = @stdout
      $stderr = @stderr

      Vedeu::Application.start(configuration)

      @exit_code = 0

    rescue StandardError => uncaught_exception
      Vedeu.log_stdout(message: uncaught_exception.message)

      if configuration.debug?
        Vedeu.log_stdout(message: uncaught_exception.backtrace.join("\n"))
      end
    end

    protected

    # @!attribute [r] argv
    # @return [Array<String>] The command line arguments provided.
    attr_reader :argv

    private

    # :nocov:
    # Terminates the application after resetting $stdin, $stdout and $stderr.
    #
    # @return [void]
    def terminate!
      Vedeu.log(type: :info, message: 'Exiting gracefully.')

      $stdin  = STDIN
      $stdout = STDOUT
      $stderr = STDERR

      @kernel.exit(exit_code)
    end
    # :nocov:

    # Use the arguments passed on the command-line along with those defined by
    # the client application and Vedeu's defaults to configure the client
    # application.
    #
    # @return [Vedeu::Configuration]
    def configuration
      Vedeu::Configuration.configure(argv)

      # Configuration.configure(argv, { stdin:  @stdin,
      #                                 stdout: @stdout,
      #                                 stderr: @stderr })
    end

  end # Launcher

end # Vedeu
