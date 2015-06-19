module Vedeu

  # Validates that the provided coordinates are within the terminal and
  # interface's geometry (with or without a border).
  class PositionValidator

    extend Forwardable

    def_delegators :border,
                   :bx,
                   :bxn,
                   :by,
                   :byn

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
      @x = bx  if x < bx
      @x = bxn if x > bxn
      @y = by  if y < by
      @y = byn if y > byn

      self
    end

    protected

    # @!attribute [r] name
    # @return [String]
    attr_reader :name

    private

    # @see Vedeu::Borders#by_name
    def border
      @border ||= Vedeu.borders.by_name(name)
    end

  end # PositionValidator

end # Vedeu
