module Vedeu

  # Store and retrieve virtual terminals.
  #
  module VirtualBuffer

    extend self

    # Fetch the oldest stored virtual buffer first.
    #
    # @return [Array<Array<Vedeu::Char>>]
    def retrieve
      storage.pop
    end

    # Store a new virtual buffer.
    #
    # @return [Array<Array<Vedeu::Char>>]
    def store(data)
      storage.unshift(data)
    end

    # Return the number of virtual buffers currently stored.
    #
    # @return [Fixnum]
    def size
      storage.size
    end

    # Destroy all virtual buffers currently stored.
    #
    # @return [Array]
    def clear
      @_storage = in_memory
    end
    alias_method :reset, :clear

    private

    # Access to the storage for this repository.
    #
    # @return [Array]
    def storage
      @_storage ||= in_memory
    end

    # Returns an empty collection ready for the storing of virtual buffers.
    #
    # @return [Array]
    def in_memory
      []
    end

  end # VirtualBuffer

end # Vedeu
