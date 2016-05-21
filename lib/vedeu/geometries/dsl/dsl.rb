# frozen_string_literal: true

module Vedeu

  module Geometries

    # Geometry allows the configuration of the position and size of an
    # interface. Within Vedeu, as the same for ANSI terminals, has the
    # origin at top-left, y = 1, x = 1. The 'y' coordinate is
    # deliberately first.
    #
    # The Geometry DSL can be used within the Interface DSL or
    # standalone. Here are example of declarations for a `geometry`
    # block:
    #
    # A standalone geometry definition:
    #
    #   Vedeu.geometry :some_interface do
    #     height 5 # Sets the height of the view to 5
    #     width 20 # Sets the width of the view to 20
    #     x 3      # Start drawing 3 spaces from left
    #     y 10     # Start drawing 10 spaces from top
    #     xn 30    # Stop drawing 30 spaces from the left
    #     yn 20    # Stop drawing 20 spaces from top
    #   end
    #
    # An interface including a geometry definition:
    #
    #   Vedeu.interface :some_interface do
    #     geometry do
    #       height 5
    #       width 20
    #       x 3
    #       y 10
    #       xn 30
    #       yn 20
    #     end
    #     # ... some code here
    #   end
    #
    # If a declaration is omitted for `height` or `width` the full
    # remaining space available in the terminal will be used. `x` and
    # `y` both default to 1.
    #
    # You can also make a geometry declaration dependent on another
    # view:
    #
    #   Vedeu.interface :other_panel do
    #     # ... some code here
    #   end
    #
    #   Vedeu.interface :main do
    #     geometry do
    #       height 10
    #       y { use(:other_panel).south }
    #     end
    #     # ... some code here
    #   end
    #
    #
    # This view will begin just below "other\_panel".
    #
    # This crude ASCII diagram represents a Geometry within Vedeu,
    # each of the labels is a value you can access or define.
    #
    #        x    north    xn           # north:  y - 1
    #      y +--------------+           # top:    y
    #        |     top      |           # west:   x - 1
    #        |              |           # left:   x
    #   west | left   right | east      # right:  xn
    #        |              |           # east:   xn + 1
    #        |    bottom    |           # bottom: yn
    #     yn +--------------+           # south:  yn + 1
    #             south
    #
    # @api public
    #
    class DSL

      include Vedeu::Common
      include Vedeu::DSL
      include Vedeu::DSL::Geometry
      include Vedeu::DSL::Use

      # Align the interface/view horizontally or vertically within
      # the terminal.
      #
      # {include:file:docs/dsl/by_method/geometry/align.md}
      # @param vertical [Symbol] One of :bottom, :middle, :none, :top.
      # @param horizontal [Symbol] One of :center, :centre, :left,
      #   :none, :right.
      # @param width [Fixnum] The number of characters/columns wide;
      #   this is required when the given value for horizontal is any
      #   value other than :none.
      # @param height [Fixnum] The number of lines/rows tall; this is
      #   required when the given value for vertical is any value
      #   other than :none.
      # @macro raise_invalid_syntax
      # @return [Vedeu::Geometries::Geometry]
      def align(vertical: :none, horizontal: :none, width: nil, height: nil)
        horizontal_alignment(horizontal, width)
        vertical_alignment(vertical, height)
      end

      # @param value [Symbol] One of :center, :centre, :left, :none,
      #   :right.
      # @param width [Fixnum] The number of characters/columns.
      # @param x [Fixnum] When given, sets the x coordinate.
      # @return [Vedeu::Geometries::Geometry]
      def horizontal_alignment(value = :none, width = nil, x = nil)
        alignment = Vedeu::Coercers::HorizontalAlignment.validate(value)

        model.width = width if width
        model.horizontal_alignment = alignment
        model.x = x if x
        model
      end

      # @param value [Symbol] One of :bottom, :middle, :none, :top.
      # @param height [Fixnum] The number of lines/rows.
      # @param y [Fixnum] When given, sets the y coordinate.
      # @return [Vedeu::Geometries::Geometry]
      def vertical_alignment(value = :none, height = nil, y = nil)
        alignment = Vedeu::Coercers::VerticalAlignment.validate(value)

        model.height = height if height
        model.vertical_alignment = alignment
        model.y = y if y
        model
      end

      # {include:file:docs/dsl/by_method/geometry/align_bottom.md}
      # @param height [Fixnum] The number of lines/rows.
      # @return [Vedeu::Geometries::Geometry]
      def align_bottom(height = nil)
        y = if height
              Vedeu.height - height
            elsif model.height
              Vedeu.height - model.height
            end

        vertical_alignment(:bottom, height, y)
      end

      # {include:file:docs/dsl/by_method/geometry/align_centre.md}
      # @param width [Fixnum] The number of characters/columns.
      # @return [Vedeu::Geometries::Geometry]
      def align_centre(width = nil)
        x = if width
              Vedeu.centre_x - (width / 2)
            elsif model.width
              Vedeu.centre_x - (model.width / 2)
            end

        horizontal_alignment(:centre, width, x)
      end
      alias align_center align_centre

      # {include:file:docs/dsl/by_method/geometry/align_left.md}
      # @param width [Fixnum] The number of characters/columns.
      # @return [Vedeu::Geometries::Geometry]
      def align_left(width = nil)
        horizontal_alignment(:left, width)
      end

      # {include:file:docs/dsl/by_method/geometry/align_middle.md}
      # @param height [Fixnum] The number of lines/rows.
      # @return [Vedeu::Geometries::Geometry]
      def align_middle(height = nil)
        y = if height
              Vedeu.centre_y - (height / 2)
            elsif model.height
              Vedeu.centre_y - (model.height / 2)
            end

        vertical_alignment(:middle, height, y)
      end

      # {include:file:docs/dsl/by_method/geometry/align_right.md}
      # @param width [Fixnum] The number of characters/columns.
      # @return [Vedeu::Geometries::Geometry]
      def align_right(width = nil)
        x = if width
              Vedeu.width - width
            elsif model.width
              Vedeu.width - model.width
            end

        horizontal_alignment(:right, width, x)
      end

      # {include:file:docs/dsl/by_method/geometry/align_top.md}
      # @param height [Fixnum] The number of lines/rows.
      # @return [Vedeu::Geometries::Geometry]
      def align_top(height = nil)
        vertical_alignment(:top, height)
      end

      # {include:file:docs/dsl/by_method/geometry/columns.md}
      # @param value [Fixnum]
      # @macro raise_out_of_range
      # @return [Fixnum|Vedeu::Error::OutOfRange]
      def columns(value)
        Vedeu::Geometries::Grid.columns(value)
      end

      # {include:file:docs/dsl/by_method/geometry/height.md}
      # @param value [Fixnum]
      # @return [Fixnum]
      def height(value)
        model.height = proc { value }
      end
      alias height= height

      # {include:file:docs/dsl/by_method/geometry/rows.md}
      # @param value [Fixnum]
      # @macro raise_out_of_range
      # @return [Fixnum]
      def rows(value)
        Vedeu::Geometries::Grid.rows(value)
      end

      # {include:file:docs/dsl/by_method/geometry/width.md}
      # @param value [Fixnum] The number of characters/columns.
      # @return [Fixnum]
      def width(value)
        model.width = proc { value }
      end
      alias width= width

      # {include:file:docs/dsl/by_method/geometry/x.md}
      # @param value [Fixnum]
      # @macro param_block
      # @return [Fixnum]
      def x(value = 1, &block)
        return model.x = block if block_given?

        model.x = value
      end
      alias x= x

      # {include:file:docs/dsl/by_method/geometry/xn.md}
      # @param value [Fixnum]
      # @macro param_block
      # @return [Fixnum]
      def xn(value = 1, &block)
        return model.xn = block if block_given?

        model.xn = value
      end
      alias xn= xn

      # {include:file:docs/dsl/by_method/geometry/y.md}
      # @param value [Fixnum]
      # @macro param_block
      # @return [Fixnum]
      def y(value = 1, &block)
        return model.y = block if block_given?

        model.y = value
      end
      alias y= y

      # {include:file:docs/dsl/by_method/geometry/yn.md}
      # @param value [Fixnum]
      # @macro param_block
      # @return [Fixnum]
      def yn(value = 1, &block)
        return model.yn = block if block_given?

        model.yn = value
      end
      alias yn= yn

    end # DSL

  end # Geometries

  # @api public
  # @!method geometry
  #   @see Vedeu::Geometries::DSL.geometry
  def_delegators Vedeu::Geometries::DSL,
                 :geometry

end # Vedeu
