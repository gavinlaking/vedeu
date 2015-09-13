module Vedeu

  module Geometry

    # Crudely corrects out of range values.
    #
    class Coordinate

      extend Forwardable

      def_delegators :x,
                     :x_position,
                     :xn

      def_delegators :y,
                     :y_position,
                     :yn

      # Returns a new instance of Vedeu::Geometry::Coordinate.
      #
      # @param name [String]
      # @param oy [Fixnum]
      # @param ox [Fixnum]
      # @return [Vedeu::Geometry::Coordinate]
      def initialize(name, oy, ox)
        @name = name
        @ox   = ox
        @oy   = oy
      end

      private

      # Provide an instance of Vedeu::Geometry::GenericCoordinate to determine
      # correct x related coordinates.
      #
      # @return [Vedeu::Geometry::GenericCoordinate]
      def x
        @x ||= Vedeu::Geometry::GenericCoordinate.new(name:   @name,
                                                      offset: @ox,
                                                      type:   :x)
      end

      # Provide an instance of Vedeu::Geometry::GenericCoordinate to determine
      # correct y related coordinates.
      #
      # @return [Vedeu::Geometry::GenericCoordinate]
      def y
        @y ||= Vedeu::Geometry::GenericCoordinate.new(name:   @name,
                                                      offset: @oy,
                                                      type:   :y)
      end

    end # Coordinate

  end # Geometry

end # Vedeu
