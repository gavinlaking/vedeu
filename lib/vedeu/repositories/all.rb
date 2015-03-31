require_relative 'collection'
require_relative 'collections/all'
require_relative 'model'
require_relative 'repositories/all'
require_relative 'repository'

module Vedeu

  module Repositories

    extend self

    def register(klass)
      storage.add(klass)
    end

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
