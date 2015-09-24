module Vedeu

  module Geometry

    # @todo Consider storing the Terminal size at the time of first
    # creation, this allows us to return the interface to its original
    # dimensions if the terminal resizes back to normal size.
    #
    # Calculates and provides interface geometry determined by both
    # the client's requirements and the terminal's current viewing
    # area.
    #
    class Geometry

      extend Forwardable
      include Vedeu::Repositories::Model

      def_delegators :area,
                     :north,
                     :east,
                     :south,
                     :west,
                     :top,
                     :right,
                     :bottom,
                     :left,
                     :y,
                     :xn,
                     :yn,
                     :x,
                     :height,
                     :width

      # @!attribute [rw] centred
      # @return [Boolean]
      attr_accessor :centred

      # @!attribute [rw] name
      # @return [String]
      attr_accessor :name

      # @!attribute [r] attributes
      # @return [Hash]
      attr_reader :attributes

      # @!attribute [w] height
      # @return [Fixnum]
      attr_writer :height

      # @!attribute [rw] maximised
      # @return [Boolean]
      attr_accessor :maximised
      alias_method :maximised?, :maximised

      # @!attribute [w] width
      # @return [Fixnum]
      attr_writer :width

      # @!attribute [w] x
      # @return [Fixnum]
      attr_writer :x

      # @!attribute [w] xn
      # @return [Fixnum]
      attr_writer :xn

      # @!attribute [w] y
      # @return [Fixnum]
      attr_writer :y

      # @!attribute [w] yn
      # @return [Fixnum]
      attr_writer :yn

      # @param attributes [Hash] See #initialize
      # @return [Vedeu::Geometry::Geometry]
      def self.store(attributes)
        new(attributes).store
      end

      # Returns a new instance of Vedeu::Geometry::Geometry.
      #
      # @param attributes [Hash]
      # @option attributes centred [Boolean]
      # @option attributes maximised [Boolean]
      # @option attributes height [Fixnum]
      # @option attributes name [String]
      # @option attributes repository [Vedeu::Geometry::Repository]
      # @option attributes width [Fixnum]
      # @option attributes x [Fixnum]
      # @option attributes xn [Fixnum]
      # @option attributes y [Fixnum]
      # @option attributes yn [Fixnum]
      # @return [Vedeu::Geometry::Geometry]
      def initialize(attributes = {})
        @attributes = defaults.merge!(attributes)

        @attributes.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Geometry::Geometry]
      # @return [Boolean]
      def eql?(other)
        self.class == other.class && name == other.name
      end
      alias_method :==, :eql?

      # Will maximise the named interface geometry. This means it will
      # occupy all of the available space on the terminal window.
      #
      # @example
      #   Vedeu.trigger(:_maximise_, name)
      #
      # @return [Vedeu::Geometry::Geometry|NilClass]
      def maximise
        return self if maximised?

        Vedeu.trigger(:_clear_)

        @maximised = true

        work = store

        Vedeu.trigger(:_refresh_, name)

        work
      end

      # Moves the geometry down by one row.
      #
      # TODO: Move cursor also.
      # @return [Vedeu::Geometry::Geometry]
      def move_down
        if yn + 1 > Vedeu.height
          dy  = y
          dyn = yn
        else
          dy  = y + 1
          dyn = yn + 1
        end

        Vedeu::Geometry::Geometry.store(move_attributes.merge!(y: dy, yn: dyn))
      end

      # Moves the geometry left by one column.
      #
      # TODO: Move cursor also.
      # @return [Vedeu::Geometry::Geometry]
      def move_left
        if x - 1 < 1
          dx  = x
          dxn = xn
        else
          dx  = x - 1
          dxn = xn - 1
        end

        Vedeu::Geometry::Geometry.store(move_attributes.merge!(x: dx, xn: dxn))
      end

      # Moves the geometry to the top left of the terminal.
      #
      # TODO: Move cursor also.
      # @return [Vedeu::Geometry::Geometry]
      def move_origin
        Vedeu::Geometry::Geometry.store(
          move_attributes.merge!(x:  1,
                                 xn: (xn - x + 1),
                                 y:  1,
                                 yn: (yn - y + 1)))
      end

      # Moves the geometry right by one column.
      #
      # TODO: Move cursor also.
      # @return [Vedeu::Geometry::Geometry]
      def move_right
        if xn + 1 > Vedeu.width
          dx  = x
          dxn = xn
        else
          dx  = x + 1
          dxn = xn + 1
        end

        Vedeu::Geometry::Geometry.store(move_attributes.merge!(x: dx, xn: dxn))
      end

      # Moves the geometry up by one column.
      #
      # TODO: Move cursor also.
      # @return [Vedeu::Geometry::Geometry]
      def move_up
        if y - 1 < 1
          dy  = y
          dyn = yn
        else
          dy  = y - 1
          dyn = yn - 1
        end

        Vedeu::Geometry::Geometry.store(move_attributes.merge!(y: dy, yn: dyn))
      end

      # Will unmaximise the named interface geometry. Previously, when
      # a geometry was maximised, then triggering the unmaximise event
      # will return it to its usual defined size (terminal size
      # permitting: when the terminal has been resized, then the new
      # geometry size should adapt).
      #
      # @example
      #   Vedeu.trigger(:_unmaximise_, name)
      #
      # @return [Vedeu::Geometry::Geometry|NilClass]
      def unmaximise
        return self unless maximised?

        Vedeu.trigger(:_clear_)

        @maximised = false

        work = store

        Vedeu.trigger(:_refresh_)

        work
      end

      private

      # @return [Vedeu::Geometry::Area]
      def area
        @area = Vedeu::Geometry::Area.from_attributes(area_attributes)
      end

      # @return [Hash<Symbol => Boolean, Fixnum>]
      def area_attributes
        {
          y:         _y,
          yn:        _yn,
          y_yn:      _height,
          y_default: Vedeu.height,
          x:         _x,
          xn:        _xn,
          x_xn:      _width,
          x_default: Vedeu.width,
          centred:   centred,
          maximised: maximised,
        }
      end

      # @return [Hash<Symbol => Boolean, Fixnum>]
      def move_attributes
        @attributes.merge(
          centred:   false,
          maximised: false,
          x:         x,
          xn:        xn,
          y:         y,
          yn:        yn)
      end

      # Returns the row/line start position for the interface.
      #
      # @return [Fixnum]
      def _y
        @y.is_a?(Proc) ? @y.call : @y
      end

      # Returns the row/line end position for the interface.
      #
      # @return [Fixnum]
      def _yn
        @yn.is_a?(Proc) ? @yn.call : @yn
      end

      # Returns the column/character start position for the interface.
      #
      # @return [Fixnum]
      def _x
        @x.is_a?(Proc) ? @x.call : @x
      end

      # Returns the column/character end position for the interface.
      #
      # @return [Fixnum]
      def _xn
        @xn.is_a?(Proc) ? @xn.call : @xn
      end

      # Returns the width of the interface.
      #
      # @return [Fixnum]
      def _width
        @width.is_a?(Proc) ? @width.call : @width
      end

      # Returns the height of the interface.
      #
      # @return [Fixnum]
      def _height
        @height.is_a?(Proc) ? @height.call : @height
      end

      # Returns the default options/attributes for this class.
      #
      # @return [Hash]
      def defaults
        {
          centred:    nil,
          height:     nil,
          maximised:  false,
          name:       nil,
          repository: Vedeu.geometries,
          width:      nil,
          x:          nil,
          xn:         nil,
          y:          nil,
          yn:         nil,
        }
      end

    end # Geometry

  end # Geometry

end # Vedeu
