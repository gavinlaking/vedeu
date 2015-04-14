module Vedeu

  # Provides a non-existent Vedeu::Interface that acts like the real thing, but
  # does nothing.
  #
  class NullInterface

    # @!attribute [r] attributes
    # @return [Hash]
    attr_reader :attributes

    # @param attributes [Hash]
    # @return [Vedeu::NullInterface]
    def initialize(attributes = {})
      @attributes = attributes
    end

  end # NullInterface

end # Vedeu
