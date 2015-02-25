module Vedeu

  class VirtualTerminal

    attr_accessor :renderer
    attr_reader :cell_height, :cell_width, :height, :width

    # @param height [Fixnum]
    # @param width [Fixnum]
    # @param renderer [Object|HTMLRenderer] An object responding to .render.
    # @return [Vedeu::VirtualTerminal]
    def initialize(height, width, renderer = HTMLRenderer)
      @cell_height, @cell_width = Vedeu::PositionIndex[height, width]
      @height   = height
      @width    = width
      @renderer = renderer
    end

    # @return [Array<Array<Vedeu::Char>>]
    def cells
      @cells ||= new_virtual_terminal
    end

    # Read a single cell from the virtual terminal.
    #
    # @param y [Fixnum]
    # @param x [Fixnum]
    # @return [Vedeu::Char]
    def read(y, x)
      cy, cx = Vedeu::PositionIndex[y, x]

      row  = fetch(cells, cy)
      cell = fetch(row, cx)

      cell
    end

    # Write a collection of cells to the virtual terminal.
    #
    # @param data [Array<Array<Vedeu::Char>>]
    # @return [Array<Array<Vedeu::Char>>]
    def output(data)
      Array(data).flatten.each do |char|
        write(char.y, char.x, char) if char.is_a?(Vedeu::Char)
      end

      cells
    end

    # @return [void]
    def render
      renderer.render(cells)
    end

    # Removes all content from the virtual terminal; effectively clearing it.
    #
    # @return [Array<Array<Vedeu::Char>>]
    def reset
      @cells = new_virtual_terminal
    end
    alias_method :clear, :reset

    # Write a single cell to the virtual terminal.
    #
    # @param y [Fixnum]
    # @param x [Fixnum]
    # @param data [Vedeu::Char]
    # @return [Vedeu::Char]
    def write(y, x, data)
      cy, cx = Vedeu::PositionIndex[y, x]

      return false unless read(y, x).is_a?(Vedeu::Char)

      cells[cy][cx] = data
      true
    end

    private

    # @param from [Array]
    # @param which [Array]
    # @return [Array<Vedeu::Char>|Array]
    def fetch(from, which)
      from[which] || []
    end

    # @return [Array<Array<Vedeu::Char>>]
    def new_virtual_terminal
      Array.new(cell_height) { Array.new(cell_width) { Vedeu::Char.new } }
    end

  end # VirtualTerminal

end # Vedeu

