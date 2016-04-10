# frozen_string_literal: true

module Vedeu

  # A class responsible for plugin loading.
  #
  # @api private
  #
  class Plugin

    # @!attribute [r] name
    # @macro return_name
    attr_reader :name

    # @!attribute [r] gem
    # @return [String]
    attr_reader :gem

    # @!attribute [r] gem_name
    # @return [String]
    attr_reader :gem_name

    # @!attribute [rw] enabled
    # @return [Boolean]
    attr_accessor :enabled
    alias enabled? enabled

    # Returns a new instance of Vedeu::Plugin.
    #
    # @macro param_name
    # @param gem [Gem::Specification] The RubyGems gem.
    # @return [Vedeu::Plugin]
    def initialize(name, gem)
      @name     = name
      @gem      = gem
      @gem_name = "vedeu_#{name}"
      @enabled  = false
    end

    # Load the plugin (require the gem).
    #
    # @macro raise_fatal
    # @return [void]
    def load!
      begin
        require gem_name unless enabled?
      rescue LoadError => error
        raise Vedeu::Error::Fatal,
              "Unable to load plugin #{gem_name} due to #{error}."
      rescue => error
        raise Vedeu::Error::Fatal,
              "require '#{gem_name}' failed with #{error}."
      end

      @enabled = true
    end

  end # Plugin

end # Vedeu
