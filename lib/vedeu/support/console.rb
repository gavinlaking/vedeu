require 'vedeu/support/read'
require 'vedeu/support/write'

module Vedeu

  # An abstract terminal class.
  #
  class Console

    attr_reader :height,
      :origin,
      :width

    alias_method :tyn, :height
    alias_method :yn, :height
    alias_method :x, :origin
    alias_method :y, :origin
    alias_method :tx, :origin
    alias_method :ty, :origin
    alias_method :txn, :width
    alias_method :xn, :width

    # @param height [Fixnum]
    # @param width [Fixnum]
    # @return [Vedeu::Console]
    def initialize(height = 25, width = 80)
      @height = height || 25
      @width  = width  || 80
      @origin = 1
    end

    # @param data [String|NilClass]
    # @return [String]
    def input(data = nil)
      Vedeu::Read.from(self, data)
    end
    alias_method :read, :input

    # @param data [Array<Array<Char>>|Array<String>|String|NilClass]
    # @return [Array]
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

    # @param block [Proc]
    # @return [Proc]
    def cooked(&block)
      yield
    end

    # @param block [Proc]
    # @return [Proc]
    def raw(&block)
      yield
    end

    # @return [Array]
    def size
      [height, width]
    end
    alias_method :winsize, :size

  end # Console

end # Vedeu
