require 'vedeu/models/interface'

module Vedeu
  EntityNotFound = Class.new(StandardError)

  module Persistence
    extend self

    def update(name, attributes = {})
      interface = query(name)
      interface.attributes = attributes
      interface
    rescue EntityNotFound
      create(attributes)
    end

    def create(attributes)
      storage.store(attributes[:name], Interface.new(attributes))
    end

    def query(value)
      storage.select do |name, result|
        return result if name == value
      end unless value.nil? || value.empty?

      fail EntityNotFound, "Interface could not be found."
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
