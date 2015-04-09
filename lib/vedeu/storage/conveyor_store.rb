module Vedeu

  # Conveyor belt like storage. The belt can move forward (`load_next`) or
  # backwards (`load_previous`), or a named entry can be retrieved.
  #
  class ConveyorStore

    include Vedeu::Store

    # @param storage [Array]
    # @return [Vedeu::ConveyorStore]
    def initialize(storage = [])
      @storage = storage
    end

    # @return [Object]
    def load
      storage.first
    end
    alias_method :current, :load

    # @param name [String]
    # @return [Object]
    def load_named(name)
      return nil if empty?

      return nil unless storage.include?(name)

      storage.rotate!(storage.index(name))

      load
    end

    # @return [Object]
    def load_next
      storage.rotate!

      load
    end

    # @return [Object]
    def load_previous
      storage.rotate!(-1)

      load
    end

    # @param data [Object]
    # @param front [Boolean]
    def save(data, front = false)
      if front
        storage.push(data)

      else
        storage.unshift(data)

      end
    end

    private

    # @return [Array]
    def in_memory
      []
    end

  end # ConveyorStore

end # Vedeu
