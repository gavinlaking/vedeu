module Vedeu

  # Value object representing the offset (the scroll position) of the content
  # for an interface.
  #
  class Offset

    attr_reader :attributes, :name, :x, :y

    # Returns a new instance of Offset.
    #
    # @param attributes [Hash]
    # @return [Offset]
    def initialize(attributes = {})
      @attributes = defaults.merge!(attributes)
      @name       = @attributes[:name]
      @y          = @attributes[:y]
      @x          = @attributes[:x]
    end

    private

    # @return [Hash]
    def defaults
      {
        name: '',
        y:    0,
        x:    0,
      }
    end

  end # Offset

end # Vedeu
