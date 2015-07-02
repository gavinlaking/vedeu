module Vedeu

  # First-in first-out storage.
  #
  #   in -> [3] -> [2] -> [1] -> out
  #
  # @api private
  class FifoStore

    include Vedeu::Store

    # Returns a new instance of Vedeu::FifoStore.
    #
    # @param storage [Array]
    # @return [Vedeu::FifoStore]
    def initialize(storage = [])
      @storage = storage
    end

    # @return [Object]
    def load
      storage.pop
    end

    # @param data [Object]
    # @return [Array<Object>]
    def save(data)
      storage.unshift(data)
    end

    private

    # @return [Array]
    def in_memory
      []
    end

  end # FifoStore

end # Vedeu
