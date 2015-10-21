module Vedeu

  module Geometry

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
    class DSL

      include Vedeu::Common
      include Vedeu::DSL
      include Vedeu::DSL::Use

      # Specify the geometry of an interface or view with a simple
      # DSL.
      #
      #   Vedeu.geometry :some_interface do
      #     # ...
      #   end
      #
      # @param name [String|Symbol] The name of the interface or view
      #   to which this geometry belongs.
      # @param block [Proc]
      # @raise [Vedeu::Error::RequiresBlock]
      # @return [Vedeu::Geometry::Geometry]
      def self.geometry(name, &block)
        fail Vedeu::Error::RequiresBlock unless block_given?

        Vedeu::Geometry::Geometry.build(name: name, &block).store
      end

      # Instructs Vedeu to align the interface/view either left,
      # centre or right. A width is also required so that required
      # coordinates are calculated correctly.
      #
      #   Vedeu.geometry :some_interface do
      #     # :some_value must be one of: :left, :none, :center,
      #     #   :centre, or :right
      #     # `width` is a positive integer, e.g. 30
      #     alignment(:some_value, width)
      #
      #     # ... some code
      #   end
      #
      # @param value [Symbol] One of :center, :centre, :left, :none,
      #   :right.
      # @param width [Fixnum] The width of the aligned interface/view.
      # @raise [Vedeu::Error::InvalidSyntax] When the value or width
      #   is not given.
      # @return [Vedeu::Geometry::Geometry]
      # def alignment(value, width)
      #   fail Vedeu::Error::InvalidSyntax,
      #        'No alignment given. Valid values are :center, :centre, ' \
      #        ':left, :none, :right.'.freeze unless present?(value)
      #   fail Vedeu::Error::InvalidSyntax,
      #        'No width given.'.freeze unless present?(width)

      #   model.alignment = Vedeu::Geometry::Alignment.align(value)
      #   model.width     = width
      #   model
      # end

      # Align the interface/view horizontally or vertically within
      # the terminal.
      #
      # @param vertical [Symbol] One of :bottom, :middle, :none, :top.
      # @param horizontal [Symbol] One of :center, :centre, :left,
      #   :none, :right.
      # @param width [Fixnum] The number of characters/columns wide;
      #   this is required when the given value for horizontal is any
      #   value other than :none.
      # @param height [Fixnum] The number of lines/rows tall; this is
      #   required when the given value for vertical is any value
      #   other than :none.
      # @raise [Vedeu::Error::InvalidSyntax]
      #   - When the vertical is not given.
      #   - When the horizontal is not given.
      #   - When the horizontal is given (and not :none) and the width
      #     is not given.
      #   - When the vertical is given (and not :none) and the height
      #     is not given.
      # @return [Vedeu::Geometry::Geometry]
      def align(vertical, horizontal, width, height)
        fail Vedeu::Error::InvalidSyntax,
             'No vertical alignment given. Valid values are :bottom, ' \
             ':middle, :none, :top.'.freeze unless present?(vertical)
        fail Vedeu::Error::InvalidSyntax,
             'No horizontal alignment given. Valid values are :center, ' \
             ':centre, :left, :none, :right.'.freeze unless present?(horizontal)

        unless vertical == :none
          fail Vedeu::Error::InvalidSyntax,
               'No height given.'.freeze if absent?(height)
        end

        unless horizontal == :none
          fail Vedeu::Error::InvalidSyntax,
               'No width given.'.freeze if absent?(width)
        end

        horizontal_alignment(horizontal, width)
        vertical_alignment(vertical, height)
      end

      # @param value [Symbol] One of :center, :centre, :left, :none,
      #   :right.
      # @param width [Fixnum] The number of characters/columns.
      # @return [Vedeu::Geometry::Geometry]
      def horizontal_alignment(value, width)
        fail Vedeu::Error::InvalidSyntax,
             'No horizontal alignment given. Valid values are :center, ' \
             ':centre, :left, :none, :right.'.freeze unless present?(value)
        fail Vedeu::Error::InvalidSyntax,
             'No width given.'.freeze unless present?(width)

        model.horizontal_alignment = Vedeu::Geometry::HorizontalAlignment
          .align(value)
        model.width = width
        model
      end

      # @param value [Symbol] One of :bottom, :middle, :none, :top.
      # @param height [Fixnum] The number of lines/rows.
      # @return [Vedeu::Geometry::Geometry]
      def vertical_alignment(value, height)
        fail Vedeu::Error::InvalidSyntax,
             'No vertical alignment given. Valid values are :bottom, ' \
             ':middle, :none, :top.'.freeze unless present?(value)
        fail Vedeu::Error::InvalidSyntax,
             'No height given.'.freeze unless present?(height)

        model.vertical_alignment = Vedeu::Geometry::VerticalAlignment
          .align(value)
        model.height = height
        model
      end

      # Vertically align the interface/view to the bottom of the
      # terminal.
      #
      #   Vedeu.geometry :some_interface do
      #     # `height` is a positive integer, e.g. 30
      #     align_bottom 30
      #
      #     # this is the same as:
      #     # vertical_alignment(:bottom, 30)
      #
      #     # or you can use: (see notes)
      #     # align(:bottom, :none, Vedeu.width, 30)
      #
      #     # ... some code
      #   end
      #
      # @note
      #   Vedeu.width in the example above will set the width to the
      #   default width of the terminal, this can be substituted for
      #   your own positive integer.
      # @param height [Fixnum] The number of lines/rows.
      # @raise [Vedeu::Error::InvalidSyntax] When the height is not
      #   given.
      # @return [Vedeu::Geometry::Geometry]
      def align_bottom(height)
        vertical_alignment(:bottom, height)
      end

      # Horizontally align the interface/view centrally.
      #
      #   Vedeu.geometry :some_interface do
      #     # `width` is a positive integer, e.g. 30
      #     align_centre 30
      #
      #     # this is the same as:
      #     # horizontal_alignment(:centre, 30)
      #
      #     # or you can use: (see notes)
      #     # align(:none, :centre, 30, Vedeu.height)
      #
      #     # ... some code
      #   end
      #
      #   # Also allows `align_center` if preferred.
      #
      # @note
      #   Vedeu.height in the example above will set the height to the
      #   default height of the terminal, this can be substituted for
      #   your own positive integer.
      # @param width [Fixnum] The number of characters/columns.
      # @raise [Vedeu::Error::InvalidSyntax] When the width is not
      #   given.
      # @return [Vedeu::Geometry::Geometry]
      def align_centre(width)
        horizontal_alignment(:centre, width)
      end
      alias_method :align_center, :align_centre

      # Horizontally align the interface/view to the left.
      #
      #   Vedeu.geometry :some_interface do
      #     # `width` is a positive integer, e.g. 30
      #     align_left 30
      #
      #     # this is the same as:
      #     # horizontal_alignment(:left, 30)
      #
      #     # or you can use: (see notes)
      #     # align(:none, :left, 30, Vedeu.height)
      #
      #     # ... some code
      #   end
      #
      # @note
      #   Vedeu.height in the example above will set the height to the
      #   default height of the terminal, this can be substituted for
      #   your own positive integer.
      # @param width [Fixnum] The number of characters/columns.
      # @raise [Vedeu::Error::InvalidSyntax] When the width is not
      #   given.
      # @return [Vedeu::Geometry::Geometry]
      def align_left(width)
        horizontal_alignment(:left, width)
      end

      # Vertically align the interface/view to the middle of the
      # terminal.
      #
      #   Vedeu.geometry :some_interface do
      #     # `height` is a positive integer, e.g. 30
      #     align_middle 30
      #
      #     # this is the same as:
      #     # vertical_alignment(:middle, 30)
      #
      #     # or you can use: (see notes)
      #     # align(:middle, :none, Vedeu.width, 30)
      #
      #     # ... some code
      #   end
      #
      # @note
      #   Vedeu.width in the example above will set the width to the
      #   default width of the terminal, this can be substituted for
      #   your own positive integer.
      # @param height [Fixnum] The number of lines/rows.
      # @raise [Vedeu::Error::InvalidSyntax] When the height is not
      #   given.
      # @return [Vedeu::Geometry::Geometry]
      def align_middle(height)
        vertical_alignment(:middle, height)
      end

      # Align the interface/view to the right.
      #
      #   Vedeu.geometry :some_interface do
      #     # `width` is a positive integer, e.g. 30
      #     align_right 30
      #
      #     # this is the same as:
      #     # horizontal_alignment(:right, 30)
      #
      #     # or you can use: (see notes)
      #     # align(:none, :right, 30, Vedeu.height)
      #
      #     # ... some code
      #   end
      #
      # @note
      #   Vedeu.height in the example above will set the height to the
      #   default height of the terminal, this can be substituted for
      #   your own positive integer.
      # @param width [Fixnum] The number of characters/columns.
      # @raise [Vedeu::Error::InvalidSyntax] When the width is not
      #   given.
      # @return [Vedeu::Geometry::Geometry]
      def align_right(width)
        horizontal_alignment(:right, width)
      end

      # Vertically align the interface/view to the top of the
      # terminal.
      #
      #   Vedeu.geometry :some_interface do
      #     # `height` is a positive integer, e.g. 30
      #     align_top 30
      #
      #     # this is the same as:
      #     # vertical_alignment(:top, 30)
      #
      #     # or you can use: (see notes)
      #     # align(:top, :none, Vedeu.width, 30)
      #
      #     # ... some code
      #   end
      #
      # @note
      #   Vedeu.width in the example above will set the width to the
      #   default width of the terminal, this can be substituted for
      #   your own positive integer.
      # @param height [Fixnum] The number of lines/rows.
      # @raise [Vedeu::Error::InvalidSyntax] When the height is not
      #   given.
      # @return [Vedeu::Geometry::Geometry]
      def align_top(height)
        vertical_alignment(:top, height)
      end

      # Instructs Vedeu to calculate x and y geometry automatically
      # based on the centre character of the terminal, the width and
      # the height.
      #
      #   Vedeu.geometry :some_interface do
      #     centred false # or...
      #
      #     centred true  # or...
      #     centred!      # or...
      #     # ... some code
      #   end
      #
      # @param value [Boolean] Any value other than nil or false will
      #   evaluate to true.
      # @return [Boolean]
      def centred(value = true)
        boolean = value ? true : false

        model.centred = boolean
      end
      alias_method :centred!, :centred
      alias_method :centred=, :centred

      # Returns the width in characters for the number of columns
      # specified.
      #
      #   Vedeu.geometry :main_interface do
      #     # ... some code
      #     width columns(9) # Vedeu.width # => 92 (for example)
      #                      # 92 / 12 = 7
      #                      # 7 * 9 = 63
      #                      # Therefore, width is 63 characters.
      #   end
      #
      # @param value [Fixnum]
      # @raise [Vedeu::Error::OutOfRange] When the value parameter is
      #   not between 1 and 12 inclusive.
      # @return [Fixnum|Vedeu::Error::OutOfRange]
      def columns(value)
        Vedeu::Geometry::Grid.columns(value)
      end

      # Specify the number of characters/rows/lines tall the interface
      # will be. This value will be ignored when `y` and `yn` are set.
      #
      #   Vedeu.geometry :some_interface do
      #     height 8
      #     # ... some code
      #   end
      #
      # @param value [Fixnum]
      # @return [Fixnum]
      def height(value)
        model.height = proc { value }
      end
      alias_method :height=, :height

      # Returns the height in characters for the number of rows
      # specified.
      #
      #   Vedeu.geometry :main_interface do
      #     # ... some code
      #     height rows(3)  # Vedeu.height # => 38 (for example)
      #                     # 38 / 12 = 3
      #                     # 3 * 3 = 9
      #                     # Therefore, height is 9 characters.
      #   end
      #
      # @param value [Fixnum]
      # @raise [Vedeu::Error::OutOfRange] When the value parameter is
      #   not between 1 and 12 inclusive.
      # @return [Fixnum]
      def rows(value)
        Vedeu::Geometry::Grid.rows(value)
      end

      # Specify the number of characters/columns wide the interface
      # will be. This value will be ignored when `x` and `xn` are set.
      #
      #   Vedeu.geometry :some_interface do
      #     width 25
      #     # ... some code
      #   end
      #
      # @param value [Fixnum] The number of characters/columns.
      # @return [Fixnum]
      def width(value)
        model.width = proc { value }
      end
      alias_method :width=, :width

      # Specify the starting x position (column) of the interface.
      #
      #   Vedeu.geometry :some_interface do
      #     x 7 # start on column 7.
      #
      #     # start on column 8, if :other_interface changes position
      #     # then :some_interface will too.
      #     x { use(:other_interface).east }
      #     # ... some code
      #   end
      #
      # @param value [Fixnum]
      # @param block [Proc]
      # @return [Fixnum]
      def x(value = 1, &block)
        return model.x = block if block_given?

        model.x = value
      end
      alias_method :x=, :x

      # Specify the ending x position (column) of the interface.
      # This value will override `width`.
      #
      #   Vedeu.geometry :some_interface do
      #     xn 37 # end at column 37.
      #
      #     # when :other_interface changes position,
      #     # :some_interface will too.
      #     xn  { use(:other_interface).right }
      #     # ... some code
      #   end
      #
      # @param value [Fixnum]
      # @param block [Proc]
      # @return [Fixnum]
      def xn(value = 1, &block)
        return model.xn = block if block_given?

        model.xn = value
      end
      alias_method :xn=, :xn

      # Specify the starting y position (row/line) of the interface.
      #
      #   Vedeu.geometry :some_interface do
      #     y  4 # start at row 4
      #
      #     # start on row/line 3, when :other_interface changes
      #     # position, :some_interface will too.
      #     y  { use(:other_interface).north }
      #     # ... some code
      #   end
      #
      # @param value [Fixnum]
      # @param block [Proc]
      # @return [Fixnum]
      def y(value = 1, &block)
        return model.y = block if block_given?

        model.y = value
      end
      alias_method :y=, :y

      # Specify the ending y position (row/line) of the interface.
      # This value will override `height`.
      #
      #   Vedeu.geometry :some_interface do
      #     yn 24 # end at row 24.
      #
      #     # if :other_interface changes position, :some_interface
      #     # will too.
      #     yn { use(:other_interface).bottom }
      #     # ... some code
      #   end
      #
      # @param value [Fixnum]
      # @param block [Proc]
      # @return [Fixnum]
      def yn(value = 1, &block)
        return model.yn = block if block_given?

        model.yn = value
      end
      alias_method :yn=, :yn

    end # DSL

  end # Geometry

  # @!method geometry
  #   @see Vedeu::Geometry::DSL.geometry
  def_delegators Vedeu::Geometry::DSL, :geometry

end # Vedeu
