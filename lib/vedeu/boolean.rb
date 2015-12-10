module Vedeu

  class Boolean

    attr_writer :value

    def initialize(value = nil)
      self.value = value
    end

    def false?
      value.nil? || value == false
    end

    def true?
      return false if false?

      true
    end

    private

    attr_reader :value

  end # Boolean

end # Vedeu
