module Vedeu

  # Provides the mechanism to start up a generated application.
  #
  # This class loads all necessary client application files and initializes
  # Vedeu with this data, then starts the client application.
  class Bootstrap

    # @param argv [Array<String>]
    # @param entry_point [void]
    # @return [void]
    def self.start(argv = ARGV, entry_point = nil)
      new(argv, entry_point).start
    end

    # Returns a new instance of Vedeu::Bootstrap.
    #
    # @param argv [Array<String>]
    # @param entry_point [void]
    # @return [Vedeu::Bootstrap]
    def initialize(argv, entry_point)
      @argv        = argv
      @entry_point = entry_point
    end

    # Loads all of the client application files so that Vedeu has access to
    # them, calls the 'entry_point' controller, ready to start the application,
    # then launches the client application.
    #
    # @return [void]
    def start
      Vedeu.configure { log('/tmp/vedeu_bootstrap.log') }

      # config/configuration.rb is already loaded so don't load it twice
      Dir[File.join(Vedeu::Configuration.base_path, 'config/**/*')].each do |f|
        next if f =~ %r{config/configuration\.rb}
        load f
      end

      [
        'app/controllers/**/*',
        'app/helpers/**/*',
        'app/views/**/*',
        'app/models/keymaps/**/*',
      ].each { |path| load(File.join(Vedeu::Configuration.base_path, path)) }

      entry_point

      Vedeu::Launcher.execute!(argv)
    end

    protected

    # @!attribute [r] argv
    # @return [Array<String>]
    attr_reader :argv

    # @!attribute [r] entry_point
    # @return [void]
    attr_reader :entry_point

    private

    # Load each of the loadable files.
    #
    # @param path [String]
    # @return [String]
    def load(path)
      loadables(path).each { |file| Kernel.load(file) }

      path
    end

    # Collect each of the files from the client application directories by path
    # excluding '.' and '..' and only loading files with the '.rb' extension.
    #
    # @param path [String]
    # @return [Array<String>]
    def loadables(path)
      Dir.glob(path).select do |file|
        File.file?(file) && File.extname(file) == '.rb'
      end
    end

  end # Bootstrap

end # Vedeu
