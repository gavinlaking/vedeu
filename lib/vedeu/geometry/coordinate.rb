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
      # @param name [String|Symbol]
      # @param oy [Fixnum]
      # @param ox [Fixnum]
      # @return [Vedeu::Geometry::Coordinate]
      def initialize(name, oy, ox)
        @name = name
        @ox   = ox
        @oy   = oy
      end

      protected

      # @!attribute [r] name
      # @return [String|Symbol]
      attr_reader :name

      # @!attribute [rw] ox
      # @return [Fixnum]
      attr_accessor :ox

      # @!attribute [rw] oy
      # @return [Fixnum]
      attr_accessor :oy

      private

      # Provide an instance of {Vedeu::Geometry::GenericCoordinate} to
      # determine correct x related coordinates.
      #
      # @return [Vedeu::Geometry::GenericCoordinate]
      def x
        @x ||= Vedeu::Geometry::GenericCoordinate.new(name:   name,
                                                      offset: ox,
                                                      type:   :x)
      end

      # Provide an instance of {Vedeu::Geometry::GenericCoordinate} to
      # determine correct y related coordinates.
      #
      # @return [Vedeu::Geometry::GenericCoordinate]
      def y
        @y ||= Vedeu::Geometry::GenericCoordinate.new(name:   name,
                                                      offset: oy,
                                                      type:   :y)
      end

    end # Coordinate

  end # Geometry

end # Vedeu
