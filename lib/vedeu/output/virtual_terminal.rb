module Vedeu

  # Represents a {Vedeu::Terminal} view as a grid of {Vedeu::Cell} objects.
  #
  # @api private
  class VirtualTerminal

    # @!attribute [rw] renderer
    # @return [void]
    attr_accessor :renderer

    # @!attribute [r] height
    # @return [Fixnum]
    attr_reader :height

    # @!attribute [r] width
    # @return [Fixnum]
    attr_reader :width

    # Returns a new instance of Vedeu::VirtualTerminal.
    #
    # @param height [Fixnum]
    # @param width [Fixnum]
    # @param renderer [Object|Renderers::HTML] An object responding to .render.
    # @return [Vedeu::VirtualTerminal]
    def initialize(height, width, renderer = Vedeu::Renderers::HTML.new)
      @height   = height
      @width    = width
      @renderer = renderer
    end

    # Return a grid of {Vedeu::Char} objects defined by the height and width of
    # this virtual terminal.
    #
    # @return [Array<Array<Vedeu::Char>>]
    def cells
      @cells ||= new_virtual_terminal
    end

    # Read a single cell from the virtual terminal.
    #
    # @note
    #   Given two actual coordinates (y, x) e.g. (1, 1)
    #   Convert to coordinate indices (cy, cx) e.g. (0, 0)
    #   Fetch the row at cy and return the cell from cx
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

    # Send the cells to the renderer and return the rendered result.
    #
    # @return [String|void] Most likely to be a String.
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
    # @note
    #   If the position (y, x) is nil; we're out of bounds.
    #   Otherwise, write the data to (cy, cx).
    #
    # @param y [Fixnum]
    # @param x [Fixnum]
    # @param data [Vedeu::Char]
    # @return [Vedeu::Char]
    def write(y, x, data)
      return false unless read(y, x).is_a?(Vedeu::Cell)

      cy, cx = Vedeu::PositionIndex[y, x]
      cells[cy][cx] = data

      true
    end

    private

    # @param from [Array] An Array of rows, or an Array of cells.
    # @param which [Fixnum] A Fixnum representing the index; the row number or
    #   the cell number for a row.
    # @return [Array<Vedeu::Char>|Array]
    def fetch(from, which)
      from[which] || []
    end

    # @return [Array<Array<Vedeu::Cell>>]
    # @see {Vedeu::VirtualTerminal#cells}
    def new_virtual_terminal
      Array.new(height) { Array.new(width) { Vedeu::Cell.new } }
    end

  end # VirtualTerminal

end # Vedeu
