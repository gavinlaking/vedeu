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

      # @!attribute [rw] alignment
      # @return [Symbol]
      attr_accessor :alignment

      # @!attribute [rw] centred
      # @return [Boolean]
      attr_accessor :centred

      # @!attribute [rw] name
      # @return [String]
      attr_accessor :name

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

      # @!attribute [rw] client
      # @return [Object]
      attr_accessor :client

      # @param (see #initialize)
      # @return (see #initialize)
      def self.store(attributes)
        new(attributes).store
      end

      # Returns a new instance of Vedeu::Geometry::Geometry.
      #
      # @param attributes [Hash]
      # @option attributes centred [Boolean]
      # @option attributes maximised [Boolean]
      # @option attributes height [Fixnum]
      # @option attributes name [String|Symbol]
      # @option attributes repository [Vedeu::Geometry::Repository]
      # @option attributes width [Fixnum]
      # @option attributes x [Fixnum]
      # @option attributes xn [Fixnum]
      # @option attributes y [Fixnum]
      # @option attributes yn [Fixnum]
      # @return [Vedeu::Geometry::Geometry]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # @return [Hash]
      def attributes
        {
          alignment:  @alignment,
          client:     @client,
          centred:    @centred,
          height:     height,
          maximised:  @maximised,
          name:       @name,
          repository: @repository,
          width:      width,
          x:          x,
          xn:         xn,
          y:          y,
          yn:         yn,
        }
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

        @maximised = true

        store do
          Vedeu.trigger(:_clear_)
          Vedeu.trigger(:_refresh_view_, name)
        end
      end

      # Moves the geometry down by one row.
      #
      # @todo Move cursor also.
      # @return [Vedeu::Geometry::Geometry]
      def move_down
        return self if yn + 1 > Vedeu.height

        move(y: y + 1, yn: yn + 1)
      end

      # Moves the geometry left by one column.
      #
      # @todo Move cursor also.
      # @return [Vedeu::Geometry::Geometry]
      def move_left
        return self if x - 1 < 1

        move(x: x - 1, xn: xn - 1)
      end

      # Moves the geometry to the top left of the terminal.
      #
      # @todo Move cursor also.
      # @return [Vedeu::Geometry::Geometry]
      def move_origin
        move(x: 1, xn: (xn - x + 1), y: 1, yn: (yn - y + 1))
      end

      # Moves the geometry right by one column.
      #
      # @todo Move cursor also.
      # @return [Vedeu::Geometry::Geometry]
      def move_right
        return self if xn + 1 > Vedeu.width

        move(x: x + 1, xn: xn + 1)
      end

      # Moves the geometry up by one column.
      #
      # @todo Move cursor also.
      # @return [Vedeu::Geometry::Geometry]
      def move_up
        return self if y - 1 < 1

        move(y: y - 1, yn: yn - 1)
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

        @maximised = false

        store do
          Vedeu.trigger(:_clear_)
          Vedeu.trigger(:_refresh_)
          Vedeu.trigger(:_refresh_view_, name)
        end
      end

      private

      # @return [Vedeu::Geometry::Area]
      def area
        @area = Vedeu::Geometry::Area.from_attributes(area_attributes)
      end

      # @return [Hash<Symbol => Boolean, Fixnum>]
      def area_attributes
        {
          alignment: @alignment,
          centred:   @centred,
          maximised: @maximised,
          x:         @x.is_a?(Proc)      ? @x.call      : @x,
          xn:        @xn.is_a?(Proc)     ? @xn.call     : @xn,
          x_xn:      @width.is_a?(Proc)  ? @width.call  : @width,
          y:         @y.is_a?(Proc)      ? @y.call      : @y,
          yn:        @yn.is_a?(Proc)     ? @yn.call     : @yn,
          y_yn:      @height.is_a?(Proc) ? @height.call : @height,
        }
      end

      # When moving an interface;
      # 1) Reset the centred and maximised states to false; it wont be
      #    centred if moved, and cannot be moved if maximised.
      # 2) Get the current coordinates of the interface, then:
      # 3) Override the attributes with the new coordinates for
      #    desired movement; these are usually +/- 1 of the current
      #    state, depending on direction.
      #
      # @param coordinates [Hash<Symbol => Fixnum>]
      # @option coordinates x [Fixnum] The starting column/character
      #   position.
      # @option coordinates xn [Fixnum] The ending column/character
      #   position.
      # @option coordinates y [Fixnum] The starting row/line position.
      # @option coordinates yn [Fixnum] The ending row/line position.
      # @return [Hash<Symbol => Boolean, Fixnum>]
      def move(coordinates = {})
        attrs = attributes.merge!(centred: false, maximised: false)
                .merge!(coordinates)

        Vedeu::Geometry::Geometry.store(attrs)
      end

      # Returns the default options/attributes for this class.
      #
      # @return [Hash]
      def defaults
        {
          alignment:  Vedeu::Geometry::Alignment.align(:none),
          client:     nil,
          centred:    false,
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
