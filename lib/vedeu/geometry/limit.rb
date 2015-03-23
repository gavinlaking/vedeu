module Vedeu

  # Forces the value within defined limits.
  #
  class Limit

    # @param (see #initialize)
    def self.apply(v, vn, max, min = 1)
      new(v, vn, max, min).apply
    end

    # Returns a new instance of Vedeu::Limit.
    #
    # @param v [Fixnum]
    # @param vn [Fixnum]
    # @param max [Fixnum]
    # @param min [Fixnum]
    # @return [Vedeu::Limit]
    def initialize(v, vn, max, min = 1)
      @v   = v
      @vn  = vn
      @max = max
      @min = min || 1
    end

    # @return [Fixnum]
    def apply
      if (v + vn) > max
        applied = vn - ((v + vn) - max)
        return applied < min ? min : applied

      else
        vn

      end
    end

    private

    # @!attribute [r] v
    # @return [Fixnum]
    attr_reader :v

    # @!attribute [r] vn
    # @return [Fixnum]
    attr_reader :vn

    # @!attribute [r] min
    # @return [Fixnum]
    attr_reader :min

    # @!attribute [r] max
    # @return [Fixnum]
    attr_reader :max

  end # Limit

end # Vedeu
