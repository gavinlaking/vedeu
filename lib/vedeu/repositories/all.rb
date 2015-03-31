require 'vedeu/repositories/collection'
require 'vedeu/repositories/collections/all'
require 'vedeu/repositories/model'
require 'vedeu/repositories/repositories/all'
require 'vedeu/repositories/repository'

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
