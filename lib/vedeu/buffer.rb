module Vedeu
  class OutOfRangeError < StandardError; end

  class Buffer
    include Enumerable

    attr_accessor :buffer

    def initialize(options = {})
      @options = options
      @buffer  = Array.new(height) { Array.new(width) { ' ' } }
    end

    def each(&block)
      buffer.each(&block)
    end

    def contents
      puts
      buffer.map { |y| y.map { |x| print "'#{x}'" }; puts }
    end

    def cell(y, x)
      raise OutOfRangeError if invalid_reference?(y, x)
      buffer[y][x]
    end

    def set_cell(y, x, v = '')
      raise OutOfRangeError if invalid_reference?(y, x) || invalid_cell?(v)
      buffer[y][x] = v
    end

    def set_row(y = 0, v = '')
      v.chars.each_with_index { |c, i| set_cell(y, i, c) }
      row(y)
    end

    def row(y = 0)
      buffer[y]
    end
    alias_method :y, :row

    def set_column(x = 0, v = '')
      v.chars.each_with_index { |c, i| set_cell(i, x, c) }
      column(x)
    end

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

  def self.test_Vedeu__Buffer(klass = Vedeu::Buffer)
    buffer = klass.new(width: 5, height: 3)

    buffer.set_row(0, 'field')
    buffer.set_row(1, 'grows')
    buffer.set_row(2, 'maize')

    puts

    buffer.map { |y| y.map { |x| print "#{x}" }; puts }

    puts
  end
end
