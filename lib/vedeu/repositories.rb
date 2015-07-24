module Vedeu

  # Provides all registered repositories.
  #
  module Repositories

    extend self

    # Register a repository with the collection of Vedeu repositories.
    #
    # @param klass [Class]
    # @return [Set]
    def register(klass)
      storage.add(klass)
    end

    # List all models stored in each registered repository.
    #
    # @return [Array]
    def registered
      all.map do |repository|
        registered = repository.send(:registered)

        Vedeu.log(type:    :debug,
                  message: "Repository '#{repository.class.name}':" \
                           " #{registered.inspect}")

        registered
      end
    end

    # Remove all stored models from the repository.
    #
    # @return [TrueClass]
    def reset!
      all.map { |repository| repository.send(:reset) }

      true
    end

    private

    # Access all the repositories stored.
    #
    # @return [Array]
    def all
      storage.map(&:repository)
    end

    # Access to the storage for this repository.
    #
    # @return [Array]
    def storage
      @storage ||= Set.new
    end

  end # Repositories

end # Vedeu

require 'vedeu/repositories/store'
require 'vedeu/repositories/registerable'
require 'vedeu/repositories/collection'

require 'vedeu/events/event_collection'
require 'vedeu/input/keys'

require 'vedeu/models/chars'
require 'vedeu/models/interface_collection'
require 'vedeu/models/lines'
require 'vedeu/models/streams'

require 'vedeu/repositories/model'
require 'vedeu/repositories/repository'
