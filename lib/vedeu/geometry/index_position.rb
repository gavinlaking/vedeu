module Vedeu

  # Converts an index into a position for the terminal.
  #
  # When the optional offset `oy` and `ox` params are given, the they are used
  # for the starting position.
  #
  class IndexPosition

    # @param (see #initialize)
    # @return [Vedeu::Position]
    def self.[](iy, ix, oy = 1, ox = 1)
      new(iy, ix, oy, ox).[]
    end

    # @param iy [Fixnum]
    # @param ix [Fixnum]
    # @param oy [Fixnum]
    # @param ox [Fixnum]
    # @return [Vedeu::IndexPosition]
    def initialize(iy, ix, oy = 1, ox = 1)
      @iy = iy
      @ix = ix
      @oy = oy
      @ox = ox
    end

    # @return [Vedeu::Position]
    def []
      Vedeu::Position.new(y, x)
    end

    # @return [Fixnum]
    def y
      (iy <= 0) ? oy : (iy + oy)
    end
    alias_method :first, :y

    # @return [Fixnum]
    def x
      (ix <= 0) ? ox : (ix + ox)
    end
    alias_method :last, :x

    private

    # @return [Fixnum]
    def iy
      @_iy ||= (@iy <= 0) ? 0 : @iy
    end

    # @return [Fixnum]
    def ix
      @_ix ||= (@ix <= 0) ? 0 : @ix
    end

    # @return [Fixnum]
    def oy
      @_oy ||= (@oy <= 1) ? 1 : @oy
    end

    # @return [Fixnum]
    def ox
      @_ox ||= (@ox <= 1) ? 1 : @ox
    end

  end # IndexPosition

end # Vedeu
