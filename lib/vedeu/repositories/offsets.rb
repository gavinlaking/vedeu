module Vedeu

  # Repository for storing and retrieving content offsets; i.e. scroll
  # position for a named interface.
  #
  # @api private
  module Offsets

    include Common
    include Repository
    extend self

    # Add or update the offset coordinates for interface content.
    #
    # @param attributes [Hash]
    # @return [Offset]
    def add(attributes)
      validate_attributes!(attributes)

      Vedeu.log("#{action(__callee__)} offset: '#{attributes[:name]}'")

      storage.store(attributes[:name], Offset.new(attributes))
    end
    alias_method :update, :add

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
