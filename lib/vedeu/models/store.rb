module Vedeu
  module Store

    extend self

    # @param attributes [Hash]
    # @return [Hash]
    def create(attributes)
      storage.store(attributes[:name], attributes)

      Buffers.create(Interface.new(attributes))

      storage
    end

    # @param name [String]
    # @return [Hash]
    def query(name)
      storage.fetch(name) { fail EntityNotFound, 'Interface was not found.' }
    end

    # @return [Hash]
    def reset
      @storage = {}
    end

    private

    def storage
      @storage ||= {}
    end

  end
end
