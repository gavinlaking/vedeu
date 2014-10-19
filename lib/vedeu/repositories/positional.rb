module Vedeu

  module Positional

    # Add or update the offset or cursor coordinates.
    #
    # @param attributes [Hash]
    # @return [Offset]
    def add(attributes)
      validate_attributes!(attributes)

      Vedeu.log("#{action(__callee__)} positional (#{entity.to_s}): " \
                "'#{attributes[:name]}'")

      storage.store(attributes[:name], entity.new(attributes))
    end
    alias_method :update, :add

  end # Positional

end # Vedeu
