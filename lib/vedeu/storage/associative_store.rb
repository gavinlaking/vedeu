module Vedeu

  # Name/Value storage.
  #
  #   name: [value]
  #
  # @api private
  class AssociativeStore

    include Vedeu::Store

    # @param storage [Hash]
    # @return [Vedeu::AssociativeStore]
    def initialize(storage = {})
      @storage = storage
    end

    # @param name [String]
    def load(name)
      return nil if empty?

      storage[name]
    end

    # @param data [Object]
    # @param name [String|Symbol]
    def save(data, name = nil)
      if name
        storage[name] = data

      elsif data.respond_to?(:name)
        storage[data.name] = data

      end

      storage
    end

    private

    # @return [Hash]
    def in_memory
      {}
    end

  end # AssociativeStore

end # Vedeu
