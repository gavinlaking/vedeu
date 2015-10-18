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

      # @param value [Symbol] One of :center, :centre, :left, :none,
      #   :right
      # @return [Vedeu::Geometry::Geometry]
      def alignment(value, width)
        fail Vedeu::Error::InvalidSyntax,
             'No alignment given. Valid values are :center, :centre, :left, ' \
             ':none, :right.'.freeze unless present?(value)
        fail Vedeu::Error::InvalidSyntax, 'No width given.'.freeze unless present?(width)

        model.alignment = Vedeu::Geometry::Alignment.align(value)
        model.width     = width
        model
      end

      # @param width [Fixnum]
      # @return [Vedeu::Geometry::Geometry]
      def align_centre(width)
        alignment(:centre, width)
      end
      alias_method :align_center, :align_centre

      # @param width [Fixnum]
      # @return [Vedeu::Geometry::Geometry]
      def align_left(width)
        alignment(:left, width)
      end

      # @param width [Fixnum]
      # @return [Vedeu::Geometry::Geometry]
      def align_right(width)
        alignment(:right, width)
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
      # @param value [Fixnum]
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
