module Vedeu

  module Geometry

    # Validate values given to {Vedeu::Geometry::DSL}.
    #
    module Validator

      include Vedeu::Common

      # @param value [Fixnum] The number of lines/rows.
      # @raise [Vedeu::Error::InvalidSyntax] When the value is nil.
      # @return [TrueClass]
      def validate_height!(value)
        fail Vedeu::Error::InvalidSyntax,
             'No height given.'.freeze if absent?(value)

        true
      end

      # @param value [Symbol] One of :center, :centre, :left,
      #   :none, :right.
      # @raise [Vedeu::Error::InvalidSyntax] When the value is nil.
      # @return [TrueClass]
      def validate_horizontal_alignment!(value)
        fail Vedeu::Error::InvalidSyntax,
             'No horizontal alignment given. Valid values are :center, ' \
             ':centre, :left, :none, :right.'.freeze unless present?(value)

        true
      end

      # @param value [Symbol] One of :bottom, :middle, :none, :top.
      # @raise [Vedeu::Error::InvalidSyntax] When the value is nil.
      # @return [TrueClass]
      def validate_vertical_alignment!(value)
        fail Vedeu::Error::InvalidSyntax,
             'No vertical alignment given. Valid values are :bottom, ' \
             ':middle, :none, :top.'.freeze unless present?(value)

        true
      end

      # @param value [Fixnum] The number of characters/columns.
      # @raise [Vedeu::Error::InvalidSyntax] When the value is nil.
      # @return [TrueClass]
      def validate_width!(value)
        fail Vedeu::Error::InvalidSyntax,
             'No width given.'.freeze if absent?(value)

        true
      end

    end # Validator

  end # Geometry

end # Vedeu
