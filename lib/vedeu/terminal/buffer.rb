module Vedeu

  module Terminal

    # All output will be written to this singleton, and #render will
    # be called at the end of each run of {Vedeu::MainLoop};
    # effectively rendering this buffer to each registered renderer.
    # This buffer is not cleared after this action though, as
    # subsequent actions will modify the contents. This means that
    # individual parts of Vedeu can write content here at various
    # points and only at the end of each run of {Vedeu::MainLoop} will
    # it be actually output 'somewhere'.
    #
    module Buffer

      extend self

      # Return a grid of {Vedeu::Models::Cell} objects defined by the
      # height and width of this virtual terminal.
      #
      # @return [Array<Array<Vedeu::Models::Cell>>]
      def buffer
        @output ||= Array.new(Vedeu.height) do |y|
          Array.new(Vedeu.width) do |x|
            Vedeu::Models::Cell.new(position: [y + 1, x + 1])
          end
        end
      end
      alias_method :cells, :buffer

      # Clear the output.
      #
      # @example
      #   Vedeu.clear
      #
      # @return [String|void] Most likely to be a String.
      def clear
        reset

        Vedeu.renderers.clear if Vedeu.ready?
      end

      # @return [Vedeu::Models::Page]
      def output
        Vedeu::Models::Page.coerce(buffer)
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

      # Send the cells to the renderer and return the rendered result.
      #
      # @param value [Array<Array<Vedeu::Views::Char>>|NilClass]
      # @return [String|void] Most likely to be a String.
      def render(value = nil)
        write(value) unless value.nil?

        Vedeu.renderers.render(output) if Vedeu.ready?
      end

      # Removes all content from the virtual terminal; effectively
      # clearing it.
      #
      # @return [Array<Array<Vedeu::Models::Cell>>]
      def reset
        @output = Array.new(Vedeu.height) do |y|
          Array.new(Vedeu.width) do |x|
            Vedeu::Models::Cell.new(position: [y + 1, x + 1])
          end
        end
      end

      # Write a collection of cells to the virtual terminal.
      #
      # @param value [Array<Array<Vedeu::Views::Char>>]
      # @return [Array<Array<Vedeu::Views::Char>>]
      def write(value)
        values = Array(value).flatten

        values.each do |v|
          buffer[v.position.y][v.position.x] = v if valid_position?(v)
        end

        self
      end

      private

      # @param from [Array] An Array of rows, or an Array of cells.
      # @param which [Fixnum] A Fixnum representing the index; the row
      #   number or the cell number for a row.
      # @return [Array<Vedeu::Views::Char>|Array]
      def fetch(from, which)
        from[which] || []
      end

      # Returns a boolean indicating the value has a position
      # attribute.
      #
      # @param value [void]
      # @return [Boolean]
      def position?(value)
        value.respond_to?(:position) &&
          value.position.is_a?(Vedeu::Geometry::Position)
      end

      # Returns a boolean indicating the value has a position
      # attribute and is within the terminal boundary.
      #
      # @param value [void]
      # @return [Boolean]
      def valid_position?(value)
        position?(value) && within_terminal_boundary?(value)
      end

      # Returns a boolean indicating the position of the value object
      # is valid for this terminal.
      #
      # @param value [void]
      # @return [Boolean]
      def within_terminal_boundary?(value)
        buffer[value.position.y] && buffer[value.position.y][value.position.x]
      end

    end # Buffer

  end # Terminal

  # @!method clear
  #   @see Vedeu::Terminal::Buffer#clear
  def_delegators Vedeu::Terminal::Buffer, :clear

end # Vedeu
