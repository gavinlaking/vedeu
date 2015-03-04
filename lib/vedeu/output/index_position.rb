module Vedeu

  # Converts an index into a position for the terminal.
  #
  class IndexPosition

    attr_reader :y,
      :x

    alias_method :first, :y
    alias_method :last, :x

    # @param y [Fixnum]
    # @param x [Fixnum]
    # @return [Array]
    def self.[](y, x)
      new(y, x).[]
    end

    # @param y [Fixnum]
    # @param x [Fixnum]
    # @return [Vedeu::IndexPosition]
    def initialize(y, x)
      @y = (y <= 0) ? 1 : (y + 1)
      @x = (x <= 0) ? 1 : (x + 1)
    end

    # @return [Array]
    def []
      [y, x]
    end

  end # IndexPosition

end # Vedeu
