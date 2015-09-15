module Vedeu

  # Represents a {Vedeu::Terminal} view as a grid of
  # {Vedeu::Models::Cell} objects.
  #
  class VirtualBuffer

    # @!attribute [rw] renderer
    # @return [void]
    attr_accessor :renderer

    # @!attribute [r] height
    # @return [Fixnum]
    attr_reader :height

    # @!attribute [r] width
    # @return [Fixnum]
    attr_reader :width

    # @param data [Array<Array<Vedeu::Views::Char>>]
    # @return [Array<Array<Vedeu::Views::Char>>]
    # @see Vedeu::VirtualBuffer#output
    def self.output(data)
      new(Vedeu.height, Vedeu.width, Vedeu::Renderers::HTML.new).output(data)
    end

    # Returns a new instance of Vedeu::VirtualBuffer.
    #
    # @param height [Fixnum]
    # @param width [Fixnum]
    # @param renderer [Object|Vedeu::Renderers::HTML] An object
    #   responding to .render.
    # @return [Vedeu::VirtualBuffer]
    def initialize(height, width, renderer = Vedeu::Renderers::HTML.new)
      @height   = height
      @width    = width
      @renderer = renderer
    end

    # Return a grid of {Vedeu::Views::Char} objects defined by the
    # height and width of this virtual terminal.
    #
    # @return [Array<Array<Vedeu::Views::Char>>]
    def cells
      @cells ||= new_virtual_buffer
    end

    # Read a single cell from the virtual terminal.
    #
    # @note
    #   Given two actual coordinates (y, x) e.g. (1, 1)
    #   Convert to coordinate indices (cy, cx) e.g. (0, 0)
    #   Fetch the row at cy and return the cell from cx
    #
    # @param y [Fixnum] The row/line coordinate.
    # @param x [Fixnum] The column/character coordinate.
    # @return [Vedeu::Views::Char]
    def read(y, x)
      cy, cx = Vedeu::Geometry::Position[y, x].as_indices

      row  = fetch(cells, cy)
      cell = fetch(row, cx)

      cell
    end

    # Write a collection of cells to the virtual terminal.
    #
    # @param data [Array<Array<Vedeu::Views::Char>>]
    # @return [Array<Array<Vedeu::Views::Char>>]
    def output(data)
      Array(data).flatten.each do |char|
        write(char.y, char.x, char) if char.is_a?(Vedeu::Views::Char)
      end

      cells
    end

    # Send the cells to the renderer and return the rendered result.
    #
    # @return [String|void] Most likely to be a String.
    def render
      renderer.render(cells)
    end

    # Removes all content from the virtual terminal; effectively
    # clearing it.
    #
    # @return [Array<Array<Vedeu::Views::Char>>]
    def reset
      @cells = new_virtual_buffer
    end
    alias_method :clear, :reset

    # Write a single cell to the virtual terminal.
    #
    # @note
    #   If the position (y, x) is nil; we're out of bounds.
    #   Otherwise, write the data to (cy, cx).
    #
    # @param y [Fixnum] The row/line coordinate.
    # @param x [Fixnum] The column/character coordinate.
    # @param data [Vedeu::Views::Char]
    # @return [Vedeu::Views::Char]
    def write(y, x, data)
      return false unless read(y, x).is_a?(Vedeu::Models::Cell)

      cy, cx = Vedeu::Geometry::Position[y, x].as_indices
      cells[cy][cx] = data

      true
    end

    private

    # @param from [Array] An Array of rows, or an Array of cells.
    # @param which [Fixnum] A Fixnum representing the index; the row
    #   number or the cell number for a row.
    # @return [Array<Vedeu::Views::Char>|Array]
    def fetch(from, which)
      from[which] || []
    end

    # @return [Array<Array<Vedeu::Models::Cell>>]
    # @see Vedeu::VirtualBuffer#cells
    def new_virtual_buffer
      Array.new(height) { Array.new(width) { Vedeu::Models::Cell.new } }
    end

  end # VirtualBuffer

end # Vedeu
