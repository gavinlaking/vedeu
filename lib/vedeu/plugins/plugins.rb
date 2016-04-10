# frozen_string_literal: true

module Vedeu

  # A class responsible for managing plugins installation.
  #
  # @api private
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
    # @return [Array<void>]
    def load
      plugins.each { |plugin| plugin.load! unless plugin.enabled? }
    end

    # Register plugin with name in an internal array.
    #
    # @macro param_name
    # @param plugin [Vedeu::Plugin]
    # @return [Array<void>]
    def register(name, plugin = false)
      Vedeu.log(type:    :debug,
                message: "Attempting to register plugin: #{name}")

      plugins << plugin if plugin && not_loaded?(name)
    end

    # Find all installed plugins and store them.
    #
    # @return [Array<void>]
    def find
      Gem.refresh

      Gem::Specification.each do |gem|
        next unless gem.name =~ /^#{prefix}/

        plugin_name = gem.name[/^#{prefix}(.*)/, 1]

        register(plugin_name, Vedeu::Plugin.new(plugin_name, gem))
      end

      plugins
    end

    # Return a list of all plugin names as strings.
    #
    # @return [Hash]
    def names
      collection = {}
      plugins.each_with_object(collection) do |hash, plugin|
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
    # @macro param_name
    # @return [Boolean]
    def not_loaded?(name)
      plugins.empty? || plugins.any? { |plugin| plugin.gem_name != name }
    end

    # @return [String]
    def prefix
      'vedeu_'
    end

  end # Plugins

end # Vedeu
