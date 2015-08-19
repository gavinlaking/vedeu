module Vedeu

  class Direct

    def self.write(value:, x:, y:)
      new(value: value, x: x, y: y).write
    end

    def initialize(value:, x:, y:)
      @value = value || ''
      @x     = x     || 1
      @y     = y     || 1
    end

    def write
      Vedeu::Terminal.output(output)

      output
    end

    protected

    # @attribute [r] value
    # @return [String]
    attr_reader :value

    # @attribute [r] x
    # @return [Fixnum]
    attr_reader :x

    # @attribute [r] y
    # @return [Fixnum]
    attr_reader :y

    private

    def output
      position + value
    end

    def position
      Vedeu::Position.new(y, x).to_s
    end

  end # Direct

end # Vedeu
