module Vedeu
  module Store

    extend self

    # @param []
    # @return []
    def create(attributes)
      storage.store(attributes[:name], attributes)

      Buffers.create(Interface.new(attributes))

      storage
    end

    # @param []
    # @return []
    def query(name)
      storage.fetch(name) { fail EntityNotFound, 'Interface was not found.' }
    end

    # @return []
    def reset
      @storage = {}
    end

    private

    def storage
      @storage ||= {}
    end

  end
end
