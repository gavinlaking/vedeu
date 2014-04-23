module Vedeu
  class OutOfRangeError < StandardError; end

  class Buffer
    include Enumerable

    attr_accessor :buffer

    # @param  options [Hash]
    # @return         [Vedeu::Buffer]
    def initialize(options = {})
      @options = options
      @buffer  = Array.new(height) { Array.new(width) { :cell } }
    end

    # @return [NilClass]
    def to_s
      each { |row| puts row.inspect }
      nil
    end

    # @return [Enumerator]
    def each(&block)
      buffer.each(&block)
    end

    # @param  y [Integer]
    # @param  x [Integer]
    # @return   [Array, OutOfRangeError]
    def cell(y, x)
      raise OutOfRangeError if invalid_reference?(y, x)
      buffer[y][x]
    end

    # @param  y [Integer]
    # @param  x [Integer]
    # @param  v [Value]
    # @return   [String, OutOfRangeError]
    def set_cell(y, x, v = '')
      raise OutOfRangeError if invalid_reference?(y, x)
      buffer[y][x] = v
    end

    # @param  y [Integer]
    # @param  v [String, Mask]
    # @return   [Array]
    def set_row(y = 0, v = '')
      if v.is_a?(String)
        v.chars.each_with_index { |c, i| set_cell(y, i, c) }
      else
        v.each_with_index { |el, i| set_cell(y, i, el) }
      end
      row(y)
    end

    # @param  y [Integer]
    # @return   [Array]
    def row(y = 0)
      buffer[y]
    end
    alias_method :y, :row

    # @param  x [Integer]
    # @param  v [Value]
    # @return   [Array]
    def set_column(x = 0, v = '')
      if v.is_a?(String)
        v.chars.each_with_index { |c, i| set_cell(i, x, c) }
      else
        v.each_with_index { |el, i| set_cell(i, x, el) }
      end
      column(x)
    end

    # @param  x [Integer]
    # @return   [Array]
    def column(x = 0)
      buffer.inject([]) { |a, e| a << e[x] }
    end
    alias_method :x, :column

    private

    def invalid_reference?(y, x)
      invalid_line?(y) || invalid_column?(x)
    end

    def invalid_line?(y)
      y < 0 || y > (height - 1)
    end

    def invalid_column?(x)
      x < 0 || x > (width - 1)
    end

    def width
      options.fetch(:width)
    end
    alias_method :columns, :width

    def height
      options.fetch(:height)
    end
    alias_method :lines, :height

    def options
      defaults.merge!(@options)
    end

    def defaults
      Vedeu::Terminal.size
    end
  end
end
