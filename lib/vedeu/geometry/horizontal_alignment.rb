module Vedeu

  module Geometry

    # Provides the mechanism to align an interface/view horizontally
    # within the available terminal space.
    #
    class HorizontalAlignment < Vedeu::Geometry::Alignment

      # @raise [Vedeu::Error::InvalidSyntax] When the value is not one
      #   of :bottom, :centre, :left, :middle, :right, :top.
      # @return [Symbol]
      def align
        return value if valid?

        fail Vedeu::Error::InvalidSyntax,
             'No horizontal alignment value given. Valid values are :center, ' \
             ':centre, :left, :none, :right.'.freeze
      end

    end # HorizontalAlignment

  end # Geometry

end # Vedeu
