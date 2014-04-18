module Vedeu
  class OutOfRangeError < StandardError; end

  class Buffer
    include Enumerable

    attr_accessor :buffer

    # @param  options [Hash]
    # @return         [Vedeu::Buffer]
    def initialize(options = {})
      @options = options
      @buffer  = Array.new(height) { Array.new(width) { ' ' } }
    end

    # @return [Enumerator]
    def each(&block)
      buffer.each(&block)
    end

    # @return [String]
    def contents
      puts
      buffer.map { |y| y.map { |x| print "'#{x}'" }; puts }
    end

    # @param  y [Integer]
    # @param  x [Integer]
    # @return   [String, OutOfRangeError]
    def cell(y, x)
      raise OutOfRangeError if invalid_reference?(y, x)
      buffer[y][x]
    end

    # @param  y [Integer]
    # @param  x [Integer]
    # @return   [String, OutOfRangeError]
    def set_cell(y, x, v = '')
      raise OutOfRangeError if invalid_reference?(y, x) || invalid_cell?(v)
      buffer[y][x] = v
    end

    # @param  y [Integer]
    # @param  v [String]
    # @return      [Array]
    def set_row(y = 0, v = '')
      v.chars.each_with_index { |c, i| set_cell(y, i, c) }
      row(y)
    end

    # @param  y [Integer]
    # @return   [Array]
    def row(y = 0)
      buffer[y]
    end
    alias_method :y, :row

    # @param  x [Integer]
    # @param  v [String]
    # @return   [Array]
    def set_column(x = 0, v = '')
      v.chars.each_with_index { |c, i| set_cell(i, x, c) }
      column(x)
    end

    # @param  x [Integer]
    # @return   [Array]
    def column(x = 0)
      buffer.inject([]) { |a, e| a << e[x] }
    end
    alias_method :x, :column

    private

    def invalid_cell?(v)
      v.size != 1
    end

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
      {
        width:  4,
        height: 3
      }
    end
  end
end
