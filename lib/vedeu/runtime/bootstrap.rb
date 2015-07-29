module Vedeu

  # Provides the mechanism to start up a generated application.
  #
  # This class loads all necessary client application files and initializes
  # Vedeu with this data, then starts the client application.
  #
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
    def initialize(argv, entry_point = nil)
      @argv        = argv
      @entry_point = entry_point
    end

    # Loads all of the client application files so that Vedeu has access to
    # them, calls the 'entry_point' controller, ready to start the application,
    # then launches the client application.
    #
    # @return [void]
    def start
      configure_log!
      client_configuration!
      client_application!
      client_initialize!

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

    # @return [String]
    def base_path
      Vedeu::Configuration.base_path
    end

    # @note
    #   config/configuration.rb is already loaded so don't load it twice
    # @return [void]
    def client_configuration!
      Dir[File.join(base_path, 'config/**/*')].each do |path|
        next if path =~ %r{config/configuration\.rb}

        load(path)
      end
    end

    # @return [void]
    def client_application!
      [
        'app/views/templates/**/*',
        'app/views/interfaces/**/*',
        'app/controllers/**/*',
        'app/helpers/**/*',
        'app/views/**/*',
        'app/models/keymaps/**/*',
      ].each { |path| load(File.join(base_path, path)) }
    end

    # @return [void]
    def client_initialize!
      entry_point || root
    end

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

    # @return [void]
    def configure_log!
      Vedeu.configure do
        log('/tmp/vedeu_bootstrap.log')
      end unless Vedeu::Configuration.log?
    end

    # @return [Class]
    def root
      Object.const_get(Vedeu::Configuration.root) if Vedeu::Configuration.root
    end

  end # Bootstrap

end # Vedeu
