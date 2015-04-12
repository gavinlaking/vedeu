module Vedeu

  class NullInterface

    # @!attribute [r] attributes
    # @return [Hash]
    attr_reader :attributes

    def initialize(attributes = {})
      @attributes = attributes
    end

  end # NullInterface

end # Vedeu
