require 'vedeu/dsl/components/geometry'
require 'vedeu/models/model'
require 'vedeu/support/esc'
require 'vedeu/support/terminal'

module Vedeu

  # @todo Consider storing the Terminal size at the time of first creation,
  # this allows us to return the interface to its original dimensions if
  # the terminal resizes back to normal size.

  # Calculates and provides interface geometry determined by both the client's
  # requirements and the terminal's current viewing area.
  #
  # Geometry for Vedeu, as the same for ANSI terminals, has the origin at
  # top-left, y = 1, x = 1. The 'y' coordinate is deliberately first.
  #
  #       x    north    xn           # north:  y - 1
  #     y +--------------+           # top:    y
  #       |     top      |           # west:   x - 1
  #       |              |           # left:   x
  #  west | left   right | east      # right:  xn
  #       |              |           # east:   xn + 1
  #       |    bottom    |           # bottom: yn
  #    yn +--------------+           # south:  yn + 1
  #            south
  #
  # @api private
  class Geometry

    include Vedeu::Model

    attr_accessor :centred, :height, :name, :width
    attr_reader   :attributes
    attr_writer   :x, :y

    class << self

      # Build models using a simple DSL when a block is given, otherwise returns
      # a new instance of the class including this module.
      #
      # @param attributes [Hash]
      # @param block [Proc]
      # @return [Class]
      def build(attributes = {}, &block)
        attributes = defaults.merge(attributes)

        model = new(attributes)
        model.deputy(attributes[:client]).instance_eval(&block) if block_given?
        model
      end

      private

      # The default values for a new instance of this class.
      #
      # @return [Hash]
      def defaults
        {
          client: nil
        }
      end

    end

    # Returns a new instance of Geometry.
    #
    # @param attributes [Hash]
    # @option attributes centred [Boolean]
    # @option attributes height [Fixnum]
    # @option attributes name [String]
    # @option attributes width [Fixnum]
    # @option attributes x [Fixnum]
    # @option attributes xn [Fixnum]
    # @option attributes y [Fixnum]
    # @option attributes yn [Fixnum]
    # @return [Geometry]
    def initialize(attributes = {})
      @attributes = defaults.merge(attributes)

      @centred = @attributes[:centred]
      @height  = @attributes[:height]
      @name    = @attributes[:name]
      @width   = @attributes[:width]
      @x       = @attributes[:x]
      @xn      = @attributes[:xn]
      @y       = @attributes[:y]
      @yn      = @attributes[:yn]
      @repository = Vedeu.geometries
    end

    # Returns log friendly output.
    #
    # @note
    #   The attribute format is (specified/calculated).
    #
    # @return [String]
    def inspect
      "<#{self.class.name} (height:(#{@height}/#{height}) " \
                           "width:(#{@width}/#{width}) " \
                           "top:#{top} " \
                           "bottom:#{bottom} " \
                           "left:#{left} " \
                           "right:#{right})>"
    end

    # Returns the row/line start position for the interface.
    #
    # @return [Fixnum]
    def y
      if @y.is_a?(Proc)
        @y.call

      else
        @y

      end
    end

    # Returns the row/line end position for the interface.
    #
    # @return [Fixnum]
    def yn
      if @yn.is_a?(Proc)
        @yn.call

      else
        @yn

      end
    end

    # Returns the column/character start position for the interface.
    #
    # @return [Fixnum]
    def x
      if @x.is_a?(Proc)
        @x.call

      else
        @x

      end
    end

    # Returns the column/character end position for the interface.
    #
    # @return [Fixnum]
    def xn
      if @xn.is_a?(Proc)
        @xn.call

      else
        @xn

      end
    end

    # Returns a dynamic value calculated from the current terminal width,
    # combined with the desired column start point.
    #
    # If the interface is `centred` then if the terminal resizes, this value
    # should attempt to accommodate that.
    #
    # For uncentred interfaces, when the terminal resizes, then this will help
    # Vedeu render the view to ensure no row/line overruns or that the content
    # is not off-screen.
    #
    # @return [Fixnum]
    def width
      if (x + @width) > Terminal.width
        new_width = @width - ((x + @width) - Terminal.width)
        return new_width < 1 ? 1 : new_width

      else
        @width

      end
    end

    # Returns a dynamic value calculated from the current terminal height,
    # combined with the desired row start point.
    #
    # If the interface is `centred` then if the terminal resizes, this value
    # should attempt to accommodate that.
    #
    # For uncentred interfaces, when the terminal resizes, then this will help
    # Vedeu render the view to ensure the content is not off-screen.
    #
    # @return [Fixnum]
    def height
      if (y + @height) > Terminal.height
        new_height = @height - ((y + @height) - Terminal.height)
        return new_height < 1 ? 1 : new_height

      else
        @height

      end
    end

    # Returns an escape sequence to position the cursor at the top-left
    # coordinate, relative to the interface's position.
    #
    # @param index [Fixnum]
    # @param block [Proc]
    # @return [String]
    def origin(index = 0, &block)
      Esc.set_position(virtual_y[index], left, &block)
    end

    # Returns the top coordinate of the interface, a fixed or dynamic value
    # depending on whether the interface is centred or not.
    #
    # @return [Fixnum]
    def top
      if centred
        Terminal.centre_y - (height / 2)

      else
        y

      end
    end

    # Returns the row above the top by default.
    #
    # @example
    #   `top` is 4.
    #
    #   north     # => 3
    #   north(2)  # => 2
    #   north(-4) # => 8
    #
    # @param value [Fixnum]
    # @return [Fixnum]
    def north(value = 1)
      top - value
    end

    # Returns the left coordinate of the interface, a fixed or dynamic value
    # depending on whether the interface is centred or not.
    #
    # @return [Fixnum]
    def left
      if centred
        Terminal.centre_x - (width / 2)

      else
        x

      end
    end

    # Returns the column before left by default.
    #
    # @example
    #   `left` is 8.
    #
    #   west      # => 7
    #   west(2)   # => 6
    #   west(-4)  # => 12
    #
    # @param value [Fixnum]
    # @return [Fixnum]
    def west(value = 1)
      left - value
    end

    # Returns the bottom coordinate of the interface, a fixed or dynamic value
    # depending on the value of {#top}.
    #
    # @return [Fixnum]
    def bottom
      top + height
    end

    # Returns the row below the bottom by default.
    #
    # @example
    #   `bottom` is 12.
    #
    #   south     # => 13
    #   south(2)  # => 14
    #   south(-4) # => 8
    #
    # @param value [Fixnum]
    # @return [Fixnum]
    def south(value = 1)
      bottom + value
    end

    # Returns the right coordinate of the interface, a fixed or dynamic value
    # depending on the value of {#left}.
    #
    # @return [Fixnum]
    def right
      left + width
    end

    # Returns the column after right by default.
    #
    # @example
    #   `right` is 19.
    #
    #   east     # => 20
    #   east(2)  # => 21
    #   east(-4) # => 15
    #
    # @param value [Fixnum]
    # @return [Fixnum]
    def east(value = 1)
      right + value
    end

    # Provides a virtual y position within the interface's dimensions.
    #
    # @example
    #   # top = 3
    #   # bottom = 6
    #   # virtual_y # => [3, 4, 5]
    #
    # @return [Array]
    def virtual_y
      (top...bottom).to_a
    end

    # Provides a virtual x position within the interface's dimensions.
    #
    # @example
    #   # left = 9
    #   # right = 13
    #   # virtual_x # => [9, 10, 11, 12]
    #
    # @return [Array]
    def virtual_x
      (left...right).to_a
    end

    private

    # The default values for a new instance of this class.
    #
    # @return [Hash]
    def defaults
      {
        centred: false,
        height:  Terminal.height,
        name:    '',
        width:   Terminal.width,
        x:       1,
        xn:      Terminal.width,
        y:       1,
        yn:      Terminal.height,
      }
    end

  end # Geometry

end # Vedeu
