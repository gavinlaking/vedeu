module Vedeu
  EntityNotFound = Class.new(StandardError)

  module Store
    extend self

    def create(attributes)
      storage.store(attributes[:name], attributes)

      Buffers.create(Interface.new(attributes))

      storage
    end

    def query(name)
      storage.fetch(name) { fail EntityNotFound, 'Interface was not found.' }
    end

    def reset
      @storage = {}
    end

    private

    def storage
      @storage ||= {}
    end
  end
end
