module Vedeu

  # A Dimension is either the height or width of an entity.
  #
  class Dimension

    # @param attributes [Hash<Symbol => Fixnum, NilClass>]
    # @options attributes d       [Fixnum|NilClass] The starting value (y or x).
    # @options attributes dn      [Fixnum|NilClass] The ending value (yn or xn).
    # @options attributes d_dn    [Fixnum|NilClass] A width or a height.
    # @options attributes default [Fixnum|NilClass] The terminal width or height.
    # @return [Vedeu::Dimension]
    def initialize(attributes = {})
      @d       = attributes[:d]
      @dn      = attributes[:dn]
      @d_dn    = attributes[:d_dn]
      @default = attributes[:default]
    end

    # @return [Fixnum]
    def d1
      dimension.first
    end

    # @return [Fixnum]
    def d2
      dimension.last
    end

    private

    # @return [Array]
    def dimension
      @dimension ||= if @d && @dn
        [@d, @dn]

      elsif @d && @d_dn
        [@d, (@d + @d_dn)]

      elsif @d_dn
        [1, @d_dn]

      elsif @d
        [@d, @default]

      else
        [1, @default]

      end
    end

    # @!attribute [r] d
    # @return [Fixnum]
    attr_reader :d

    # @!attribute [r] dn
    # @return [Fixnum]
    attr_reader :dn

    # @!attribute [r] d_dn
    # @return [Fixnum]
    attr_reader :d_dn

    # @!attribute [r] default
    # @return [Fixnum]
    attr_reader :default

  end # Dimension

end # Vedeu
