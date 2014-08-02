require 'vedeu/models/interface'

# Todo: mutation (persistence)

module Vedeu
  EntityNotFound = Class.new(StandardError)

  module InterfaceStore
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

    def query(interface_name)
      storage.select do |name, interface|
        return interface if name == interface_name
      end unless interface_name.nil? || interface_name.empty?

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
