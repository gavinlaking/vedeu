module Vedeu

  # Represents a empty model.
  #
  class Null

    # @return [Vedeu::Null]
    def initialize; end

    # @return [NilClass]
    def add(*)
      nil
    end

    # @return [NilClass]
    def colour
      nil
    end

    # @return [NilClass]
    def parent
      nil
    end

    # @return [Vedeu::Null]
    def store
      self
    end

    # @return [NilClass]
    def style
      nil
    end

    # @return [FalseClass]
    def visible?
      false
    end
    alias_method :visible, :visible?

    # @return [FalseClass]
    def visible=(*)
      false
    end

  end # Null

end # Vedeu
