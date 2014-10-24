module Vedeu

  # Repository helper module which reduces duplication in Offsets and Cursors.
  #
  module Positional

    # Add or update the offset or cursor coordinates.
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

  end # Positional

end # Vedeu
