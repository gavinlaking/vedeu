module Vedeu

  # Provides a non-existent Vedeu::Border that acts like the real thing, but
  # does nothing.
  #
  class NullBorder

    # @!attribute [r] name
    # @return [String|NilClass]
    attr_reader :name

    # Returns a new instance of Vedeu::NullBorder.
    #
    # @param name [String|NilClass]
    # @return [Vedeu::NullBorder]S
    def initialize(name = nil)
      @name = name
    end

    # @return [Fixnum]
    def bx
      geometry.x
    end
    alias_method :x, :bx

    # @return [Fixnum]
    def bxn
      geometry.xn
    end
    alias_method :xn, :bxn

    # @return [Fixnum]
    def by
      geometry.y
    end
    alias_method :y, :by

    # @return [Fixnum]
    def byn
      geometry.yn
    end
    alias_method :yn, :byn

    # @return [FalseClass]
    def enabled?
      false
    end

    # @return [Fixnum]
    def height
      (by..byn).size
    end

    # @return [Array]
    def render
      []
    end

    # @return [Fixnum]
    def width
      (bx..bxn).size
    end

    private

    # Returns the geometry for the interface.
    #
    # @return (see Vedeu::Geometries#by_name)
    def geometry
      @geometry ||= Vedeu.geometries.by_name(name)
    end

  end # NullBorder

end # Vedeu
