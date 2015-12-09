module Vedeu

  module Geometries

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
                     :bordered_height,
                     :bordered_width,
                     :bottom,
                     :bx,
                     :bxn,
                     :by,
                     :byn,
                     :east,
                     :height,
                     :left,
                     :north,
                     :right,
                     :south,
                     :top,
                     :west,
                     :width,
                     :x,
                     :xn,
                     :y,
                     :yn

      # @!attribute [rw] horizontal_alignment
      # @return [Symbol]
      attr_accessor :horizontal_alignment

      # @!attribute [rw] vertical_alignment
      # @return [Symbol]
      attr_accessor :vertical_alignment

      # @!attribute [rw] name
      # @return [String|Symbol]
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

      # Returns a new instance of Vedeu::Geometries::Geometry.
      #
      # @param attributes [Hash<Symbol => Boolean|Fixnum|String|
      #   Symbol|Vedeu::Geometries::Repository]
      # @option attributes horizontal_alignment [Symbol]
      # @option attributes vertical_alignment [Symbol]
      # @option attributes maximised [Boolean]
      # @option attributes height [Fixnum]
      # @option attributes name [String|Symbol]
      # @option attributes repository [Vedeu::Geometries::Repository]
      # @option attributes width [Fixnum]
      # @option attributes x [Fixnum]
      # @option attributes xn [Fixnum]
      # @option attributes y [Fixnum]
      # @option attributes yn [Fixnum]
      # @return [Vedeu::Geometries::Geometry]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # @return [Hash<Symbol => Boolean|Fixnum|String|Symbol|
      #   Vedeu::Geometries::Repository]
      def attributes
        {
          client:               client,
          height:               height,
          horizontal_alignment: horizontal_alignment,
          maximised:            maximised,
          name:                 name,
          repository:           repository,
          vertical_alignment:   vertical_alignment,
          width:                width,
          x:                    x,
          xn:                   xn,
          y:                    y,
          yn:                   yn,
        }
      end

      # Returns a DSL instance responsible for defining the DSL
      # methods of this model.
      #
      # @param client [Object|NilClass] The client binding represents
      #   the client application object that is currently invoking a
      #   DSL method. It is required so that we can send messages to
      #   the client application object should we need to.
      # @return [Vedeu::Geometries::DSL] The DSL instance for this
      #   model.
      def deputy(client = nil)
        Vedeu::Geometries::DSL.new(self, client)
      end

      # An object is equal when its values are the same.
      #
      # @param other [Vedeu::Geometries::Geometry]
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
      # @return [Vedeu::Geometries::Geometry|NilClass]
      def maximise
        return self if maximised?

        @maximised = true

        store do
          Vedeu.trigger(:_clear_)
          Vedeu.trigger(:_refresh_view_, name)
        end
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
      # @return [Vedeu::Geometries::Geometry|NilClass]
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

      # @return [Vedeu::Geometries::Area]
      def area
        Vedeu::Geometries::Area.from_attributes(area_attributes)
      end

      # @return [Hash<Symbol => Boolean|Fixnum>]
      def area_attributes
        {
          horizontal_alignment: horizontal_alignment,
          maximised:            maximised,
          name:                 name,
          vertical_alignment:   vertical_alignment,
          x:                    @x.is_a?(Proc)      ? @x.call      : @x,
          xn:                   @xn.is_a?(Proc)     ? @xn.call     : @xn,
          width:                @width.is_a?(Proc)  ? @width.call  : @width,
          y:                    @y.is_a?(Proc)      ? @y.call      : @y,
          yn:                   @yn.is_a?(Proc)     ? @yn.call     : @yn,
          height:               @height.is_a?(Proc) ? @height.call : @height,
        }
      end

      # Returns the default options/attributes for this class.
      #
      # @return [Hash<Symbol => Boolean|Fixnum|NilClass|String|Symbol|
      #   Vedeu::Geometries::Repository]
      def defaults
        {
          client:               nil,
          height:               nil,
          horizontal_alignment: :none,
          maximised:            false,
          name:                 nil,
          repository:           Vedeu.geometries,
          vertical_alignment:   :none,
          width:                nil,
          x:                    nil,
          xn:                   nil,
          y:                    nil,
          yn:                   nil,
        }
      end

    end # Geometry

  end # Geometries

end # Vedeu
