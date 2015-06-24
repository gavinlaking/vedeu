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
      [:configuration_path,
       :interface_path,
       :keymap_path].each do |path|
        load(path)
      end

      Vedeu::Launcher.execute!(argv)
    end

    protected

    # @!attribute [r] argv
    # @return [Array<String>]
    attr_reader :argv

    private

    # @return [String]
    def configuration_path
      File.dirname(__FILE__) + '/config/**/*'
    end

    # @return [String]
    def interface_path
      File.dirname(__FILE__) + '/app/views/interfaces/**/*'
    end

    # @return [String]
    def keymap_path
      File.dirname(__FILE__) + '/app/models/keymaps/**/*'
    end

    # @param path [String]
    # @return [String]
    def load(path)
      files = send(path)

      Dir.glob(files).select do |file|
        File.file?(file) && File.extname(file) == '.rb'

      end.each do |file|
        Kernel.load(file)

      end

      path
    end

  end # Bootstrap

end # Vedeu
