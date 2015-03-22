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
      interface.x
    end

    # @return [Fixnum]
    def bxn
      interface.xn
    end

    # @return [Fixnum]
    def by
      interface.y
    end

    # @return [Fixnum]
    def byn
      interface.yn
    end

    # @return [Array]
    def render
      []
    end

    private

    # @!attribute [r] interface
    # @return [Vedeu::Interface]
    attr_reader :interface

  end # NullBorder

end # Vedeu
