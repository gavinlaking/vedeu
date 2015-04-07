require 'vedeu/support/terminal'

module Vedeu

  # Validates that the provided coordinates are within the terminal and
  # interface's geometry (with or without a border).
  #
  class PositionValidator

    extend Forwardable

    def_delegators :terminal,
                   :tx,
                   :ty,
                   :txn,
                   :tyn

    def_delegators :border,
                   :enabled?,
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
    def self.validate(name, x, y)
      new(name, x, y).validate
    end

    # Returns a new instance of Vedeu::PositionValidator.
    #
    # @param name [String]
    # @param x [Fixnum]
    # @param y [Fixnum]
    # @return [PositionValidator]
    def initialize(name, x, y)
      @name = name
      @x    = x
      @y    = y
    end

    # @return [PositionValidator]
    def validate
      terminal_validation
      interface_validation
      border_validation if enabled?

      self
    end

    private

    # @!attribute [r] name
    # @return [String]
    attr_reader :name

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
      @x = left + 1   if left? && x < (left + 1)
      @x = right - 2  if right? && x > (right - 1)
      @y = top + 1    if top? && y < (top + 1)
      @y = bottom - 2 if bottom? && y > (bottom - 1)

      self
    end

    # @return [Vedeu::Border|Vedeu::NullBorder|NilClass]
    def border
      @border ||= Vedeu.borders.by_name(name)
    end

    # @return [Vedeu::Geometry|Vedeu::NullGeometry]
    def geometry
      @geometry ||= Vedeu.geometries.by_name(name)
    end

  end # PositionValidator

end # Vedeu
