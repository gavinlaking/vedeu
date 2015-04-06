require 'vedeu/support/terminal'

module Vedeu

  # Validates that the provided coordinates are within the terminal and
  # interface (with or without a border).
  #
  class PositionValidator

    extend Forwardable

    def_delegators :terminal,
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

    # @!attribute [rw] x
    # @return [Fixnum]
    attr_accessor :x

    # @!attribute [rw] x
    # @return [Fixnum]
    attr_accessor :y

    # @param (see #initialize)
    def self.validate(interface, x, y)
      new(interface, x, y).validate
    end

    # Returns a new instance of Vedeu::PositionValidator.
    #
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

    # @!attribute [r] interface
    # @return [Vedeu::Interface]
    attr_reader :interface

    # @return [Vedeu::Terminal]
    def terminal
      Vedeu::Terminal
    end

    # Validate the x and y coordinates are within the dimensions of the
    # terminal.
    #
    # @return [PositionValidator]
    def terminal_validation
      @x = tx  if x < tx
      @x = txn if x > txn
      @y = ty  if y < ty
      @y = tyn if y > tyn

      self
    end

    # Validate the x and y coordinates are within the dimensions of the
    # interface.
    #
    # @return [PositionValidator]
    def interface_validation
      @x = left   if x < left
      @x = right  if x > right
      @y = top    if y < top
      @y = bottom if y > bottom

      self
    end

    # Validate the x and y coordinates are within the dimensions of an interface
    # with a border.
    #
    # @return [PositionValidator]
    def border_validation
      @x = left + 1   if left?   && x < (left + 1)
      @x = right - 2  if right?  && x > (right - 1)
      @y = top + 1    if top?    && y < (top + 1)
      @y = bottom - 2 if bottom? && y > (bottom - 1)

      self
    end

  end # PositionValidator

end # Vedeu
