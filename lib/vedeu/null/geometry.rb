module Vedeu

  module Null

    # Provides a non-existent model to swallow messages.
    class Geometry

      extend Forwardable

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

      # @!attribute [rw] maximised
      # @return [Boolean]
      attr_accessor :maximised

      # @!attribute [r] name
      # @return [String|NilClass]
      attr_reader :name

      # Returns a new instance of Vedeu::Null::Geometry.
      #
      # @param name [String|NilClass]
      # @return [Vedeu::Null::Geometry]
      def initialize(name = nil)
        @name      = name
        @maximised = false
      end

      # @return [FalseClass]
      def centred
        false
      end

      # @return [FalseClass]
      def maximise
        false
      end

      # @return [Vedeu::Null::Geometry]
      def store
        self
      end

      # @return [FalseClass]
      def unmaximise
        false
      end

      private

      # @return [Vedeu::Area]
      def area
        @area ||= Vedeu::Area.from_dimensions(y_yn: y_yn, x_xn: x_xn)
      end

      # @return [Array<Fixnum>]
      def x_xn
        @x_xn ||= Vedeu::Dimension.pair(default: Vedeu::Terminal.width)
      end

      # @return [Array<Fixnum>]
      def y_yn
        @y_yn ||= Vedeu::Dimension.pair(default: Vedeu::Terminal.height)
      end

    end # Geometry

  end # Null

end # Vedeu
