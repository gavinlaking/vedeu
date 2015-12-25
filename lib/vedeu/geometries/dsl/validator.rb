# frozen_string_literal: true

module Vedeu

  module Geometries

    # Validate values given to {Vedeu::Geometries::DSL}.
    #
    # @api private
    #
    module Validator

      include Vedeu::Common

      # @param value [Fixnum] The number of lines/rows.
      # @raise [Vedeu::Error::InvalidSyntax] When the value is nil.
      # @return [Boolean]
      def validate_height!(value)
        fail Vedeu::Error::InvalidSyntax,
             'No height given.' if absent?(value)

        true
      end

      # @param value [Symbol] One of :center, :centre, :left,
      #   :none, :right.
      # @raise [Vedeu::Error::InvalidSyntax] When the value is nil.
      # @return [Boolean]
      def validate_horizontal_alignment!(value)
        fail Vedeu::Error::InvalidSyntax,
             'No horizontal alignment given. Valid values are :center, ' \
             ':centre, :left, :none, :right.' unless present?(value)

        true
      end

      # @param value [Symbol] One of :bottom, :middle, :none, :top.
      # @raise [Vedeu::Error::InvalidSyntax] When the value is nil.
      # @return [Boolean]
      def validate_vertical_alignment!(value)
        fail Vedeu::Error::InvalidSyntax,
             'No vertical alignment given. Valid values are :bottom, ' \
             ':middle, :none, :top.' unless present?(value)

        true
      end

      # @param value [Fixnum] The number of characters/columns.
      # @raise [Vedeu::Error::InvalidSyntax] When the value is nil.
      # @return [Boolean]
      def validate_width!(value)
        fail Vedeu::Error::InvalidSyntax,
             'No width given.' if absent?(value)

        true
      end

    end # Validator

  end # Geometries

end # Vedeu
