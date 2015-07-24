module Vedeu

  # A class responsible for managing plugins installation.
  #
  class Plugins

    # Returns a new instance of Vedeu::Plugins.
    #
    # @return [Vedeu::Plugins]
    def initialize
      @plugins = []
    end

    # Loads all plugins that are not enabled.
    #
    # @return [void]
    def load
      plugins.each do |plugin|
        plugin.load! unless plugin.enabled?
      end
    end

    # Register plugin with name in an internal array.
    #
    # @param name [String]
    # @param plugin [Vedeu::Plugin]
    # @return [void]
    def register(name, plugin = false)
      if plugin && !loaded?(name)
        plugins << plugin
      end
    end

    # Find all installed plugins and store them.
    #
    # @return [void]
    def find
      Gem.refresh

      Gem::Specification.each do |gem|
        next unless gem.name =~ /^#{prefix}/
        plugin_name = gem.name[/^#{prefix}-(.*)/, 1]
        register(plugin_name, Plugin.new(plugin_name, gem))
      end

      plugins
    end

    # Return a list of all plugin names as strings.
    #
    # @return [void]
    def names
      plugins.reduce({}) do |hash, plugin|
        hash[plugin.name] = plugin
        hash
      end
    end

    protected

    # @!attribute [r] input
    # @return [Array<String>]
    attr_accessor :plugins

    private

    # Returns a boolean indicating whether a plugin is already loaded.
    #
    # @param name [String]
    # @return [Boolean]
    def loaded?(name)
      plugins.any? { |plugin| plugin.gem_name == name }
    end

    # @return [String]
    def prefix
      'vedeu'
    end

  end # Plugins

end # Vedeu
