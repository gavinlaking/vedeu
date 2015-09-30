module Vedeu

  module Borders

    # Provides a non-existent Vedeu::Borders::Border that acts like
    # the real thing, but does nothing.
    #
    class Null

      # @!attribute [r] name
      # @return [String|Symbol|NilClass]
      attr_reader :name

      # Returns a new instance of Vedeu::Borders::Null.
      #
      # @param attributes [Hash<Symbol => void>]
      # @option attributes name [String|Symbol|NilClass]
      # @return [Vedeu::Borders::Null]
      def initialize(attributes = {})
        @attributes = attributes
        @name       = @attributes[:name]
      end

      # @return [Fixnum]
      def bx
        geometry.x
      end
      alias_method :x, :bx

      # @return [Fixnum]
      def bxn
        geometry.xn
      end
      alias_method :xn, :bxn

      # @return [Fixnum]
      def by
        geometry.y
      end
      alias_method :y, :by

      # @return [Fixnum]
      def byn
        geometry.yn
      end
      alias_method :yn, :byn

      # @return [Fixnum]
      def height
        (by..byn).size
      end

      # @return [Array]
      def render
        []
      end

      # @return [Fixnum]
      def width
        (bx..bxn).size
      end

      private

      # Returns the geometry for the interface.
      #
      # @return (see Vedeu::Geometry::Repository#by_name)
      def geometry
        @geometry ||= Vedeu.geometries.by_name(name)
      end

    end # Null

  end # Borders

end # Vedeu
