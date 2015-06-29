module Vedeu

  # Provides the mechanism to start up a generated application.
  #
  # This class loads all necessary client application files and initializes
  # Vedeu with this data, then starts the client application.
  class Bootstrap

    # @param argv [Array<String>]
    # @return [void]
    def self.start(argv = ARGV)
      new(argv).start
    end

    # @param argv [Array<String>]
    # @return [Vedeu::Bootstrap]
    def initialize(argv)
      @argv = argv
    end

    # @return [void]
    def start
      Vedeu.configure { log('/tmp/vedeu_bootstrap.log') }

      [
        './config/**/*',
        './app/controllers/**/*',
        './app/helpers/**/*',
        './app/views/**/*',
        './app/models/keymaps/**/*',
      ].each { |path| load(path) }

      Vedeu::Launcher.execute!(argv)
    end

    protected

    # @!attribute [r] argv
    # @return [Array<String>]
    attr_reader :argv

    private

    # @param path [String]
    # @return [String]
    def load(path)
      loadables(path).each { |file| Kernel.load(file) }

      path
    end

    # @param path [String]
    # @return [Array<String>]
    def loadables(path)
      Dir.glob(path).select do |file|
        File.file?(file) && File.extname(file) == '.rb'
      end
    end

  end # Bootstrap

end # Vedeu
