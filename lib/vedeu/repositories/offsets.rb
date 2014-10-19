module Vedeu

  # Repository for storing and retrieving content offsets; i.e. scroll
  # position for a named interface.
  #
  # @api private
  module Offsets

    include Common
    include Repository
    include Positional
    extend self

    # @param y [Fixnum]
    # @param x [Fixnum]
    # @return [Offset]
    def move(y, x)
      find_or_create(Focus.current).move(y, x)
    end

    private

    # @return [Class]
    def entity
      Offset
    end

    # @return [Hash]
    def in_memory
      {}
    end

  end # Offsets

end # Vedeu
