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

      Application.start(options)

      @exit_code = 0
    ensure
      $stdin, $stdout, $stderr = STDIN, STDOUT, STDERR
      @kernel.exit(@exit_code)
    end
    # :nocov:

    private

    attr_reader :argv

    def options
      options = {}

      parser = OptionParser.new do |opts|
        opts.banner = "Usage: #{$PROGRAM_NAME} [options]"

        opts.on_tail("-h", "--help", "Show this message") do |v|
          puts opts
          exit
        end

        opts.on_tail("--version", "Show version") do
          puts Vedeu::VERSION.join('.')
          exit
        end

        opts.on("-I", "--run-once", "Run application once.") do
          options[:interactive] = false
        end
      end

      begin
        parser.parse!(argv)
      rescue OptionParser::InvalidOption => e
        $stderr.puts e
        $stderr.puts parser
        exit 1
      end

      options
    end
  end
end
