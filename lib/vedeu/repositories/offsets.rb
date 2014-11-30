module Vedeu

  # Repository for storing and retrieving content offsets; i.e. scroll
  # position for a named interface.
  #
  # @api private
  module Offsets

    include Repository
    extend self

    # Add or update the offset coordinates.
    #
    # @param attributes [Hash]
    # @return [Offset]
    def add(attributes)
      validate_attributes!(attributes)

      Vedeu.log("#{action(__callee__)} positional (#{entity}): " \
                "'#{attributes[:name]}'")

      storage.store(attributes[:name], entity.new(attributes))
    end
    alias_method :update, :add

    # @return [Array]
    def down
      move(1, 0)
    end

    # @return [Array]
    def up
      move(-1, 0)
    end

    # @return [Array]
    def right
      move(0, 1)
    end

    # @return [Array]
    def left
      move(0, -1)
    end

    private

    # @param y [Fixnum]
    # @param x [Fixnum]
    # @return [Array]
    def move(y, x)
      find_or_create(Focus.current).move(y, x)

      Focus.refresh
    end

    # @return [Class] The model class for this repository.
    def model
      Vedeu::Offset
    end
    alias_method :entity, :model

    # @return [Hash]
    def in_memory
      {}
    end

  end # Offsets

end # Vedeu
