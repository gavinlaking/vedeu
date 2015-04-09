module Vedeu

  # Provides a non-existent Vedeu::Border that acts like the real thing, but
  # does nothing.
  #
  class NullBorder

    # Returns a new instance of Vedeu::NullBorder.
    #
    # @param interface [Vedeu::Interface]
    # @return [Vedeu::NullBorder]
    def initialize(interface)
      @interface = interface
    end

    # @return [Fixnum]
    def bx
      geometry.x
    end

    # @return [Fixnum]
    def bxn
      geometry.xn
    end

    # @return [Fixnum]
    def by
      geometry.y
    end

    # @return [Fixnum]
    def byn
      geometry.yn
    end

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

    # @!attribute [r] interface
    # @return [Vedeu::Interface]
    attr_reader :interface

    # Returns the geometry for the interface.
    #
    # @return [Vedeu::Geometry]
    def geometry
      interface.geometry
    end

  end # NullBorder

end # Vedeu
