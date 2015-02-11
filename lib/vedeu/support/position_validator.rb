module Vedeu

  class PositionValidator

    extend Forwardable

    def_delegators Vedeu::Terminal,
      :tx,
      :ty,
      :txn,
      :tyn

    def_delegators :interface,
      :border?,
      :border,
      :geometry

    def_delegators :border,
      :left?,
      :right?,
      :top?,
      :bottom?

    def_delegators :geometry,
      :left,
      :right,
      :top,
      :bottom

    attr_accessor :x, :y

    # @param interface [Interface]
    # @param x [Fixnum]
    # @param y [Fixnum]
    # @return [PositionValidator]
    def self.validate(interface, x, y)
      new(interface, x, y).validate
    end

    # @param interface [Interface]
    # @param x [Fixnum]
    # @param y [Fixnum]
    # @return [PositionValidator]
    def initialize(interface, x, y)
      @interface = interface
      @x         = x
      @y         = y
    end

    # @return [PositionValidator]
    def validate
      terminal_validation
      interface_validation
      border_validation if border?

      self
    end

    private

    attr_reader :interface

    def terminal_validation
      @x = tx  if x < tx
      @x = txn if x > txn
      @y = ty  if y < ty
      @y = tyn if y > tyn
    end

    def interface_validation
      @x = left   if x < left
      @x = right  if x > right
      @y = top    if y < top
      @y = bottom if y > bottom
    end

    def border_validation
      @x = left + 1   if left?   && x < (left + 1)
      @x = right - 2  if right?  && x > (right - 1)
      @y = top + 1    if top?    && y < (top + 1)
      @y = bottom - 2 if bottom? && y > (bottom - 1)
    end

    # def x
    #   @x = [[[[@x, tx].max, txn].min, left].max, right].min
    #   @x = border? && left?  ? [@x, (left + 1)].max  : @x
    #   @x = border? && right? ? [@x, (right - 2)].min : @x
    #   @x
    # end

    # def y
    #   @y = [[[[@y, ty].max, tyn].min, top].max, bottom].min
    #   @y = border? && top?    ? [@y, (top + 1)].max    : @y
    #   @y = border? && bottom? ? [@y, (bottom - 2)].min : @y
    #   @y
    # end

  end # PositionValidator

end # Vedeu
