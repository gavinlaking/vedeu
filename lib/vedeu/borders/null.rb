module Vedeu

  module Borders

    # Provides a non-existent Vedeu::Borders::Border that acts like
    # the real thing, but does nothing.
    #
    # @api private
    #
    class Null

      extend Forwardable

      def_delegators :geometry,
                     :bordered_width,
                     :bordered_height,
                     :bx,
                     :bxn,
                     :by,
                     :byn,
                     :x,
                     :xn,
                     :y,
                     :yn

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

      # @return [Boolean]
      def enabled?
        false
      end

      # @return [Array]
      def render
        []
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
