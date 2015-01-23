module Vedeu

  module Consoles

    # The HTML console takes output and converts it to HTML.
    class HTML

      def self.write(canvas, viewport, options = {})
        new(canvas, viewport, options).write
      end

      def initialize(canvas, viewport, options = {})
        @canvas   = canvas
        @viewport = viewport
        @options  = options
      end

      def write
        canvas.height.times do |cy|
          out << '<tr>'
          canvas.width.times do |cx|
            out << "<td bgcolor='' color=''>x</td>"
          end
          out << '</tr>'
        end
      end

      private

      attr_reader :canvas, :viewport

      def options
        defaults.merge(@options)
      end

      def defaults
        {
          template: '' # File.open('./templates/html.html')
        }
      end

    end # HTML

  end # Consoles

  class Canvas

    attr_reader :width
    alias_method :xn, :width

    attr_reader :height
    alias_method :yn, :height

    # Helper interface to allow us to pass IO.console.winsize to Canvas.
    #
    # @param array [Array<Fixnum>]
    # @return [Canvas]
    def self.from_a(array)
      new(array.first, array.last)
    end

    def initialize(height = 1, width = 1)
      @height = height
      @width  = width
    end

    # Returns a coordinate tuple of the format [y, x], where `y` is the row/line
    # and `x` is the column/character.
    #
    # @return [Array]
    def centre
      [(height / 2), (width / 2)]
    end

    # Returns the `y` (row/line) component of the coordinate tuple provided by
    # {Vedeu::Terminal.centre}
    #
    # @return [Fixnum]
    def centre_y
      centre.first
    end

    # Returns the `x` (column/character) component of the coodinate tuple
    # provided by {Vedeu::Terminal.centre}
    #
    # @return [Fixnum]
    def centre_x
      centre.last
    end

    def origin
      1
    end
    alias_method :x, :origin
    alias_method :y, :origin

    def size
      [height, width]
    end

  end

end # Vedeu
