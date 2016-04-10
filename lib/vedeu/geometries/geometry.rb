# frozen_string_literal: true

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
    # @api private
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

      # @!attribute [rw] client
      # @return [Object]
      attr_accessor :client

      # @!attribute [w] height
      # @return [Fixnum]
      attr_writer :height

      # @!attribute [rw] horizontal_alignment
      # @return [Symbol]
      attr_accessor :horizontal_alignment

      # @!attribute [rw] maximised
      # @return [Boolean]
      attr_accessor :maximised
      alias maximised? maximised

      # @!attribute [rw] name
      # @macro return_name
      attr_accessor :name

      # @!attribute [rw] vertical_alignment
      # @return [Symbol]
      attr_accessor :vertical_alignment

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

      # Returns a new instance of Vedeu::Geometries::Geometry.
      #
      # @param attributes [Hash<Symbol => Boolean|Fixnum|String|
      #   Symbol|Vedeu::Geometries::Repository]
      # @option attributes client [void]
      # @option attributes height [Fixnum]
      # @option attributes horizontal_alignment [Symbol]
      # @option attributes maximised [Boolean]
      # @option attributes name [String|Symbol]
      # @option attributes repository [Vedeu::Geometries::Repository]
      # @option attributes vertical_alignment [Symbol]
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

      # @return [Hash<Symbol => Boolean|Fixnum|String|Symbol>]
      def attributes
        {
          client:               client,
          height:               @height.is_a?(Proc) ? @height.call : @height,
          horizontal_alignment: horizontal_alignment,
          maximised:            maximised,
          name:                 name,
          vertical_alignment:   vertical_alignment,
          width:                @width.is_a?(Proc)  ? @width.call  : @width,
          x:                    @x.is_a?(Proc)      ? @x.call      : @x,
          xn:                   @xn.is_a?(Proc)     ? @xn.call     : @xn,
          y:                    @y.is_a?(Proc)      ? @y.call      : @y,
          yn:                   @yn.is_a?(Proc)     ? @yn.call     : @yn,
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
        self.class.equal?(other.class) && name == other.name
      end
      alias == eql?

      # {include:file:docs/events/by_name/maximise.md}
      # @return [Vedeu::Geometries::Geometry|NilClass]
      def maximise
        return self if maximised?

        @maximised = true
        @_area     = nil

        store do
          Vedeu.trigger(:_refresh_view_, name)
        end
      end

      # {include:file:docs/events/by_name/unmaximise.md}
      # @return [Vedeu::Geometries::Geometry|NilClass]
      def unmaximise
        return self unless maximised?

        @maximised = false
        @_area     = nil

        store do
          Vedeu.trigger(:_clear_)
          Vedeu.trigger(:_refresh_)
        end
      end

      # @return [Vedeu::Geometries::Repository]
      def repository
        Vedeu.geometries
      end

      private

      # @return [Vedeu::Geometries::Area]
      def area
        @_area ||= Vedeu::Geometries::Area.from_attributes(attributes)
      end

      # @macro defaults_method
      def defaults
        {
          client:               nil,
          height:               nil,
          horizontal_alignment: :none,
          maximised:            false,
          name:                 nil,
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
