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
                   :bx,
                   :bxn,
                   :by,
                   :byn

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

    # Ensures the coordinates provided are within the terminal, interface and
    # if applicable, bordered interface area.
    #
    # @return [PositionValidator]
    def validate
      if enabled?
        @x = bx  if x < bx
        @x = bxn if x > bxn
        @y = by  if y < by
        @y = byn if y > byn

      else
        @x = left   if x < left   || x < tx
        @x = right  if x > right  || x > txn
        @y = top    if y < top    || y < ty
        @y = bottom if y > bottom || y > tyn

      end

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

    # @return (see Vedeu::Borders#by_name)
    def border
      @border ||= Vedeu.borders.by_name(name)
    end

    # @return (see Vedeu::Geometries#by_name)
    def geometry
      @geometry ||= Vedeu.geometries.by_name(name)
    end

  end # PositionValidator

end # Vedeu
