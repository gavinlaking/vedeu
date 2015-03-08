module Vedeu

  # save unless saved
  # save if saved
  # load if saved
  # save_or_load # find_or_create
  # load_or_save # find_or_create

  # Name/Value storage
  #
  #   name: [value]
  #
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
