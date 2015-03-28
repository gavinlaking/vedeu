module Vedeu

  # Represents a empty model.
  #
  class Null

    # @return [Vedeu::Null]
    def initialize; end

    # @params args [NilClass]
    # @return [NilClass]
    def add(*args)
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

    # @return [NilClass]
    def style
      nil
    end

  end # Null

end # Vedeu
