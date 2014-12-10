module Vedeu

  # A Char represents a single character of the terminal. It is a container for
  # the a single character in a {Vedeu::Stream}.
  #
  # @note The parent of a Char is a Line.
  # @todo Colour and style is not being correctly reset. (GL 2014-10-19)
  #
  # @api private
  class Char

    include Presentation

    attr_reader :attributes, :parent, :value
    alias_method :data, :value

    # Returns a new instance of Char.
    #
    # @param attributes [Hash]
    # @return [Char]
    def initialize(attributes = {})
      @attributes = defaults.merge(attributes)
      @parent     = @attributes[:parent]
      @value      = @attributes[:value]
    end

    private

    # The default values for a new instance of Char.
    #
    # @return [Hash]
    def defaults
      {
        colour: {},
        parent: nil,
        style:  [],
        value:  '',
      }
    end

  end # Char

end # Vedeu
