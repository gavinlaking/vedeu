module Vedeu

  class CoercionsTestClass

    include Coercions

    attr_reader :attributes

    def initialize(attributes = {})
      @attributes = attributes
      @name       = attributes[:name]
    end

  end # CoercionsTestClass

end # Vedeu
