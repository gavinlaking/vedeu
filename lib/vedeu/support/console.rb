require 'vedeu/support/read'
require 'vedeu/support/write'

module Vedeu

  class Console

    attr_reader :height, :width
    alias_method :yn, :height
    alias_method :xn, :width

    # @param height [Fixnum]
    # @param width [Fixnum]
    def initialize(height = 25, width = 80)
      @height = height || 25
      @width  = width  || 80
    end

    # @param data [String|NilClass]
    # @return [String]
    def input(data = nil)
      Vedeu::Read.from(self, data)
    end
    alias_method :read, :input

    # @param data [Array<Array<Char>>|Array<String>|String|NilClass]
    # @return [String]
    def output(data = nil)
      Vedeu::Write.to(self, data)
    end
    alias_method :write, :output

    # Returns a coordinate tuple of the format [y, x], where `y` is the row/line
    # and `x` is the column/character.
    #
    # @return [Array]
    def centre
      [(height / 2), (width / 2)]
    end

    # Returns the `y` (row/line) component of the coordinate tuple provided by
    # {Vedeu::Terminal.centre}
    #
    # @return [Fixnum]
    def centre_y
      centre.first
    end

    # Returns the `x` (column/character) component of the coodinate tuple
    # provided by {Vedeu::Terminal.centre}
    #
    # @return [Fixnum]
    def centre_x
      centre.last
    end

    # @return [Fixnum]
    def origin
      1
    end
    alias_method :x, :origin
    alias_method :y, :origin

    # @return [Array]
    def size
      [height, width]
    end

  end # Console

end # Vedeu
