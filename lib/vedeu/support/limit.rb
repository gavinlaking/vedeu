module Vedeu

  class Limit

    def self.apply(v, vn, max, min = 1)
      new(v, vn, max, min).apply
    end

    def initialize(v, vn, max, min = 1)
      @v   = v
      @vn  = vn
      @max = max
      @min = min || 1
    end

    def apply
      if (v + vn) > max
        applied = vn - ((v + vn) - max)
        return applied < min ? min : applied

      else
        vn

      end
    end

    private

    attr_reader :v, :vn, :min, :max

  end # Limit

end # Vedeu
