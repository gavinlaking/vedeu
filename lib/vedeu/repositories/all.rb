require_relative 'collection'
require_relative 'collections/all'
require_relative 'model'
require_relative 'repositories/all'
require_relative 'repository'

module Vedeu

  # Provides all registered repositories.
  #
  module Repositories

    extend self

    # @param klass [Class]
    # @return [Set]
    def register(klass)
      storage.add(klass)
    end

    # Remove all stored models from the repository.
    #
    # @return [TrueClass]
    def reset!
      storage.map(&:repository).map { |repository| repository.send(:reset) }

      true
    end

    private

    # Access to the storage for this repository.
    #
    # @return [Array]
    def storage
      @storage ||= Set.new
    end

  end

end # Vedeu
